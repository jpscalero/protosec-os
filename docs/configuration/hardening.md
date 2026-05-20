# Manual de Hardening y Bastionado del Sistema — ProtoSec OS

La seguridad defensiva e integridad del sistema son pilares fundamentales de **ProtoSec OS**. Esta guía detalla la arquitectura de seguridad implementada en la distribución, las configuraciones de endurecimiento de servicios y las instrucciones paso a paso para gestionar las defensas activas y pasivas de tu sistema instalado.

---

## 🛡️ 1. Filosofía de Seguridad y Defensas Activas

ProtoSec OS implementa múltiples capas de defensa en profundidad. Esto garantiza que incluso si un atacante consigue evadir una barrera, existen mecanismos secundarios que restringen sus privilegios, detectan sus actividades y bloquean las conexiones automáticamente.

```
       🌐 [Red Exterior / Internet]
                 │
                 ▼  (1) Cortafuegos Activo (UFW)
      [ Filtro de Puertos y IPs ]
                 │
                 ▼  (2) Detección de Intrusos (Fail2Ban)
      [ Bloqueo Dinámico en Caliente ]
                 │
                 ▼  (3) Bastionado Criptográfico (SSH Hardened)
      [ Autenticación Robusta / RSA / Ed25519 ]
                 │
                 ▼  (4) Control de Acceso Obligatorio (AppArmor)
      [ Confinamiento de Demonios y Procesos ]
                 │
                 ▼  (5) Auditoría e Integridad (AIDE + auditd)
      [ Telemetría y Firmas de Ficheros ]
```

---

## 🚪 2. Configuración y Gestión del Cortafuegos (UFW)

El cortafuegos **UFW** (Uncomplicated Firewall) viene instalado por defecto. Una vez instalado el sistema mediante `protosec-setup`, se activa con una política por defecto restrictiva en entrada y permisiva en salida:

### Reglas Preconfiguradas por Defecto
```bash
# Activar el firewall
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Permitir puertos específicos según la necesidad
sudo ufw allow 80/tcp     # Servidor Web HTTP
sudo ufw allow 443/tcp    # Servidor Web HTTPS
sudo ufw allow 2222/tcp   # SSH Bastionado (reemplazo del puerto 22)
sudo ufw allow 51820/udp  # WireGuard VPN

# Habilitar el cortafuegos
sudo ufw enable
```

### Comandos de Diagnóstico Útiles
- Ver estado detallado y reglas numeradas:
  ```bash
  sudo ufw status verbose
  ```
- Eliminar una regla específica (ej. la regla número 3):
  ```bash
  sudo ufw delete 3
  ```

---

## 🔒 3. Detección y Mitigación Dinámica (Fail2Ban)

El servicio **Fail2Ban** escanea en tiempo real los ficheros de log de los demonios locales (SSH, bases de datos, etc.) en busca de múltiples intentos de inicio de sesión fallidos o patrones sospechosos, y bloquea de manera temporal la dirección IP origen en el firewall del sistema.

### Configuración de Jails Personalizadas (`/etc/fail2ban/jail.local`)
Se preconfiguran las siguientes reglas de protección activa:

```ini
[DEFAULT]
# Banear la IP por 1 hora si comete 5 fallos en 10 minutos
bantime  = 1h
findtime = 10m
maxretry = 5
banaction = ufw

[sshd]
enabled  = true
port     = 2222
logpath  = %(sshd_log)s
backend  = %(sshd_backend)s

[mariadb]
enabled  = true
port     = 3306
filter   = mysqld-auth
logpath  = /var/log/mysql/error.log
maxretry = 3
```

### Comandos de Control de Fail2Ban
- Comprobar el estado general del cliente:
  ```bash
  sudo fail2ban-client status
  ```
- Ver el estado de una jaula específica y las IPs actualmente bloqueadas:
  ```bash
  sudo fail2ban-client status sshd
  ```
- Desbloquear de forma manual una dirección IP baneada:
  ```bash
  sudo fail2ban-client set sshd unbanip X.X.X.X
  ```

---

## 🔑 4. Bastionado de OpenSSH Server

Si mantienes un servidor SSH abierto para administrar tu sistema ProtoSec a distancia, es fundamental aplicar reglas rígidas que impidan los ataques automatizados de fuerza bruta.

La plantilla preconfigurada en `/etc/ssh/sshd_config` contiene las siguientes directivas de hardening estricto:

```text
# Forzar puerto alternativo seguro
Port 2222

# Desactivar acceso directo a root
PermitRootLogin no

# Forzar el uso del protocolo seguro 2
Protocol 2

# Limitación de intentos y tiempos de conexión
MaxAuthTries 3
LoginGraceTime 30

# Restringir autenticación interactiva de contraseñas de texto plano
PasswordAuthentication no
PubkeyAuthentication yes

# Configurar algoritmos de cifrado y criptografía simétrica fuertes
KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,diffie-hellman-group16-sha512
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com
MACs hmac-sha2-512-etm@openssh.com
```

> [!WARNING]
> Antes de deshabilitar `PasswordAuthentication`, asegúrate de haber copiado tu clave pública RSA/Ed25519 en el fichero `/home/usuario/.ssh/authorized_keys` del servidor mediante el comando `ssh-copy-id -p 2222 usuario@servidor`. De lo contrario, perderás el acceso por red al equipo.

---

## 🧱 5. AppArmor y Perfiles de Confinamiento

**AppArmor** proporciona un sistema de control de acceso obligatorio (MAC) basado en perfiles asignados a programas específicos. Estos perfiles limitan estrictamente las capacidades de los ejecutables (lectura, escritura, puertos, llamadas al sistema), impidiendo que si un servicio es comprometido mediante un exploit de día cero, el atacante pueda tomar control de otras partes del sistema operativo.

### Comprobar Estado de AppArmor
```bash
sudo aa-status
```
*Esto mostrará qué perfiles se encuentran cargados en el kernel y cuáles están en modo enforcement (ejecutando bloqueos) o complain (registrando advertencias).*

### Gestión de Perfiles
- Poner un perfil en modo restricción estricto:
  ```bash
  sudo aa-enforce /etc/apparmor.d/usr.sbin.sshd
  ```
- Poner un perfil en modo depuración (solo advierte en logs):
  ```bash
  sudo aa-complain /etc/apparmor.d/usr.sbin.nginx
  ```

---

## 🔍 6. Integridad del Sistema con AIDE (Advanced Intrusion Detection Environment)

**AIDE** es un verificador de integridad de archivos que genera una base de datos con huellas digitales de tipo criptográfico (SHA256, SHA512) de todos los archivos esenciales del sistema operativo. Al realizar comprobaciones posteriores, AIDE reporta cualquier archivo que haya sido modificado, añadido o eliminado de forma sospechosa.

### Inicialización de la Base de Datos (Post-Instalación)
Una vez que hayas configurado tu sistema de forma estable, inicializa la base de datos de firmas:

```bash
# 1. Generar la base de datos de integridad inicial
sudo aideinit

# 2. Copiar la base de datos resultante para que sea la de referencia activa
sudo cp /var/lib/aide/aide.db.new.tar.gz /var/lib/aide/aide.db.tar.gz
```

### Ejecutar una Auditoría de Integridad
Para comprobar si algún malware o intruso ha alterado los archivos binarios del sistema (`/bin/`, `/usr/bin/`) o configuraciones críticas:

```bash
sudo aide --check
```
*Si se detectan anomalías, se reportarán detalladamente en la consola y se registrarán en `/var/log/aide/aide.log`.*

---

## 📡 7. Auditoría Avanzada con `auditd` y Detección de Rootkits

### Reglas de Auditoría (`/etc/audit/rules.d/audit.rules`)
El servicio `auditd` monitoriza a bajo nivel todas las llamadas al kernel. Se preconfigura para registrar telemetría crítica de:
- Modificación del reloj del sistema.
- Intento de carga de módulos del núcleo no firmados.
- Cambios en las cuentas de usuario locales (`/etc/passwd`).
- Accesos fallidos a archivos protegidos.

Consulta los eventos del sistema de auditoría con la utilidad especializada:
```bash
# Ver intentos fallidos de llamada al sistema de lectura de archivos
sudo ausearch -m AVC -ts today
```

### Escaneo Periódico de Rootkits
Se instalan e integran los scripts automatizados de seguridad:
- **`rkhunter`** (Rootkit Hunter)
- **`chkrootkit`**

Ambas herramientas se ejecutan en segundo plano mediante tareas cron programadas semanalmente y reportan de forma automatizada alertas en caso de detectar firmas de puertas traseras (*backdoors*) conocidas o cambios sospechosos en la memoria del kernel.
