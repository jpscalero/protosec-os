# Guía de Instalación y Despliegue — ProtoSec OS

Esta guía describe exhaustivamente los pasos requeridos para ejecutar, instalar y desplegar **ProtoSec OS** tanto en sistemas físicos (ordenadores y servidores dedicados) como en entornos virtuales de hipervisor (VirtualBox, VMware, KVM) y servidores privados virtuales (VPS).

---

## 💾 1. Creación de un Dispositivo USB Booteable

La imagen ISO generada es de tipo **híbrido**, lo que significa que es compatible con el arranque directo por bloques desde dispositivos físicos.

### En GNU/Linux y macOS (Mediante Terminal)
1. Conecta tu pendrive USB (se borrarán todos los datos).
2. Identifica el nombre de la unidad utilizando `lsblk` (ejemplo: `/dev/sdb` o `/dev/sdc`).
3. Ejecuta el comando `dd` asegurando escribir al bloque correcto y vaciar los búferes de escritura antes de retirar la unidad:
   ```bash
   sudo dd if=ProtoSec-1.0-amd64.iso of=/dev/sdX bs=4M status=progress conv=fdatasync && sync
   ```
   > [!CAUTION]
   > Reemplaza `/dev/sdX` por la unidad exacta de tu pendrive. Si seleccionas el disco duro principal de tu sistema host, destruirás tus datos de manera irreversible.

### En Windows y macOS (Mediante Herramienta Gráfica)
1. Descarga e instala la herramienta gratuita de código abierto **BalenaEtcher** (o **Rufus** en Windows).
2. Selecciona el archivo `ProtoSec-1.0-amd64.iso`.
3. Selecciona la unidad USB de destino.
4. Presiona el botón **Flash!** y espera a que finalice la verificación de integridad.

---

## 🖥️ 2. Configuración de BIOS / UEFI

Para arrancar ProtoSec OS en tu máquina física:
1. Apaga el equipo y conecta el pendrive USB.
2. Enciende el equipo e ingresa al menú de configuración de BIOS/UEFI pulsando la tecla correspondiente (`F2`, `F12`, `Del` o `Esc` según el fabricante).
3. **Secure Boot**: Se recomienda **deshabilitar** el inicio seguro (Secure Boot) para evitar conflictos con los controladores y herramientas específicas de pentesting no firmadas por Microsoft.
4. **Prioridad de Arranque**: Configura el puerto USB en primera posición de la lista de arranque.
5. Guarda los cambios y reinicia.

---

## 🚀 3. Ejecución en Modo Live (Sin Instalación)

Al arrancar se mostrará el menú del gestor de arranque de ProtoSec OS:

```text
┌────────────────────────────────────────────────────────┐
│                      PROTOSEC OS 1.0                   │
├────────────────────────────────────────────────────────┤
│  > Arracar ProtoSec OS 1.0 (Modo Live / Persistencia)   │
│    Arrancar en Modo Seguro (Failsafe graphics)         │
│    Iniciar Instalador Gráfico Directo                  │
│    Prueba de Memoria RAM (Memtest86+)                  │
└────────────────────────────────────────────────────────┘
```

Al seleccionar el **Modo Live**, el sistema operativo se cargará completamente en la memoria RAM del ordenador sin alterar el almacenamiento interno del equipo.
- **Usuario por defecto**: `protosec`
- **Contraseña**: *No tiene contraseña en modo Live (inicia sesión de forma automática).*
- **Privilegios Administrativos**: Ejecuta comandos como root utilizando `sudo` sin contraseña (ej. `sudo systemctl status mariadb`).

---

## 🎨 4. Proceso de Instalación Paso a Paso

ProtoSec OS incluye un instalador gráfico interactivo de última generación basado en **Calamares**, adaptado visualmente con el tema de la casa.

```mermaid
graph LR
    A[Idioma y Zona Horaria] --> B[Distribución de Teclado]
    B --> C[Particionado de Disco]
    C --> D[Creación de Usuario Local]
    D --> E[Resumen de Cambios]
    E --> F[Copia de Sistema y Bootloader]
```

### Pasos Guiados en el Instalador
1. **Acceso al Instalador**: En el escritorio de KDE, haz doble clic sobre el acceso directo **"Instalar ProtoSec OS"**.
2. **Ubicación e Idioma**: Selecciona el idioma de tu preferencia y tu zona horaria para ajustar el reloj de la máquina.
3. **Particionado del Disco**:
   - **Borrar Disco Completo**: Recomendado para instalaciones dedicadas o máquinas virtuales. Instala el sistema en una única partición limpia.
   - **Particionado Manual**: Si deseas configurar particiones separadas para `/boot`, `/home` y `/` (root), o configurar doble arranque (Dual Boot) al lado de Windows.
4. **Usuario y Credenciales**: Crea el usuario del sistema e introduce una contraseña robusta. *Este usuario se añadirá automáticamente al grupo de administradores (sudo).*
5. **Instalación**: Confirma los cambios. El instalador copiará el sistema de archivos de la imagen SquashFS en tu disco duro y configurará el cargador de arranque **GRUB** en la partición EFI o en el MBR.

---

## 🛠️ 5. Configuración Post-Instalación (`protosec-setup`)

Una vez completada la instalación, retira el medio USB y reinicia el equipo. En el primer arranque, abre una consola terminal Konsole y ejecuta el asistente interactivo de post-instalación de ProtoSec OS:

```bash
sudo protosec-setup
```

El script interactivo Whiptail te guiará en los siguientes procesos de hardening y personalización de red:
1.  **Hardening de SSH**: Cambia el puerto SSH por defecto de escucha (ej. del 22 al 2222), deshabilita la autenticación de contraseñas de texto plano para root y fuerza el uso exclusivo del protocolo seguro 2.
2.  **Configuración del Firewall (UFW)**: Activa el cortafuegos con políticas restrictivas de entrada y permite los puertos de servicios que realmente vayas a utilizar.
3.  **Configuración de WireGuard**: Asistente guiado para generar el par de claves criptográficas y configurar túneles VPN seguros para auditorías de red remotas.
4.  **Contraseñas de Bases de Datos**: Establece contraseñas administrativas (`root`) robustas y personalizadas para los servidores MariaDB y PostgreSQL locales instalados.

---

## 📦 6. Instalación en Entornos de Virtualización

### 6.1. Oracle VM VirtualBox
1. Crea una nueva máquina virtual:
   - **Nombre**: ProtoSec OS
   - **Tipo**: Linux
   - **Versión**: Debian (64-bit)
2. **Hardware**: Asigna un mínimo de 4096 MB de RAM y al menos 2 CPUs. Activa la casilla *Habilitar EFI* en la pestaña de placa base si deseas probar el arranque UEFI moderno.
3. **Pantalla**: Sube la memoria de vídeo al máximo (128 MB) y activa la aceleración 3D para una interfaz KDE fluida.
4. **Almacenamiento**: Crea un disco duro virtual con un tamaño mínimo de **40 GB** (se recomienda usar formato dinámico).
5. **Red**: Configura el adaptador en modo **Puente (Bridge)** para que la máquina virtual obtenga su propia dirección IP y puedas auditar la red local.
6. Carga la ISO en la unidad óptica virtual e inicia la máquina.

### 6.2. VMware Workstation / Player
1. Crea una nueva máquina virtual y selecciona la opción de cargar la ISO más tarde.
2. **Sistema Operativo**: Selecciona Linux con la plantilla **Debian 12.x de 64 bits**.
3. **Recursos**: Asigna al menos 2 núcleos de procesador y 4 GB o más de memoria RAM.
4. **Disco**: Configura una capacidad de almacenamiento mínima de 40 GB en un único archivo virtual.
5. **Tarjeta de Red**: Selecciona el adaptador de red en modo **Bridged** para operaciones de análisis de red.
6. Conecta el archivo ISO de ProtoSec OS al CD/DVD virtual y arranca la máquina.

### 6.3. Despliegue en VPS o Servidor Dedicado
Si instalas ProtoSec OS en un servidor en la nube o dedicado para usarlo como una estación de análisis y servidor de base de datos remoto de alto rendimiento:
1. Utiliza la consola de administración de tu proveedor (OVH, Hetzner, DigitalOcean) para cargar tu ISO personalizada de ProtoSec en la consola virtual.
2. Arranca mediante la consola **KVM/IPMI** y ejecuta el instalador desatendido o Calamares.
3. **IMPORTANTE**: Activa inmediatamente el servicio de cortafuegos UFW y configura el bastionado SSH con autenticación por clave pública a través del asistente `protosec-setup` para evitar accesos no autorizados en internet.
