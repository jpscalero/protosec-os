<div align="center">

```text
██████╗ ██████╗  ██████╗ ████████╗██████╗  ██████╗███████╗ ██████╗  ██████╗
██╔══██╗██╔══██╗██╔═══██╗╚══██╔══╝██╔══██╗██╔════╝██╔════╝██╔═══██╗██╔════╝
██████╔╝██████╔╝██║   ██║   ██║   ██║  ██║╚█████╗ █████╗  ██║   ██║╚█████╗
██╔═══╝ ██╔══██╗██║   ██║   ██║   ██║  ██║ ╚═══██╗██╔══╝  ██║   ██║ ╚═══██╗
██║     ██║  ██║╚██████╔╝   ██║   ██████╔╝██████╔╝███████╗╚██████╔╝██████╔╝
╚═╝     ╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═════╝
```

### 💻 *Hack. Analyze. Deploy.*

[![Versión](https://img.shields.io/badge/version-1.0.0--alpha-00FF41?style=for-the-badge&labelColor=121212)](https://github.com/jpscalero/protosec-os)
[![Base Debian](https://img.shields.io/badge/Debian-12%20Bookworm-D70A53?style=for-the-badge&logo=debian&logoColor=white&labelColor=121212)](https://debian.org)
[![Licencia](https://img.shields.io/badge/License-GPL--3.0-007ACC?style=for-the-badge&logo=gnu&logoColor=white&labelColor=121212)](LICENSE)
[![Plataforma](https://img.shields.io/badge/Platform-amd64-555555?style=for-the-badge&labelColor=121212)](https://github.com/jpscalero/protosec-os)
[![Escritorio](https://img.shields.io/badge/Desktop-KDE%20Plasma%205-1D99F3?style=for-the-badge&logo=kde&logoColor=white&labelColor=121212)](https://kde.org)
<br>
[![Compilación](https://img.shields.io/github/actions/workflow/status/jpscalero/protosec-os/build-check.yml?branch=main&style=for-the-badge&logo=github&labelColor=121212&label=Build%20Check)](https://github.com/jpscalero/protosec-os/actions)
[![ShellCheck](https://img.shields.io/github/actions/workflow/status/jpscalero/protosec-os/shellcheck.yml?branch=main&label=ShellCheck&style=for-the-badge&logo=github&labelColor=121212)](https://github.com/jpscalero/protosec-os/actions)
[![Contribuciones](https://img.shields.io/badge/Contributions-Welcome-F39C12?style=for-the-badge&labelColor=121212)](CONTRIBUTING.md)
[![Mantenido](https://img.shields.io/badge/Maintained-Yes-2ECC71?style=for-the-badge&labelColor=121212)](https://github.com/jpscalero/protosec-os)
<br>
[![Estrellas](https://img.shields.io/github/stars/jpscalero/protosec-os?style=for-the-badge&logo=github&labelColor=121212)](https://github.com/jpscalero/protosec-os/stargazers)
[![Forks](https://img.shields.io/github/forks/jpscalero/protosec-os?style=for-the-badge&logo=github&labelColor=121212)](https://github.com/jpscalero/protosec-os/network/members)
[![Issues](https://img.shields.io/github/issues/jpscalero/protosec-os?style=for-the-badge&logo=github&labelColor=121212)](https://github.com/jpscalero/protosec-os/issues)

---

</div>

## 📌 Tabla de Contenidos

1. [Descripción del Proyecto](#-descripción-del-proyecto)
2. [Características Principales](#-características-principales)
3. [Capturas de Pantalla](#-capturas-de-pantalla)
4. [Requisitos del Sistema](#-requisitos-del-sistema)
5. [Instalación y Uso](#-instalación-y-uso)
6. [Herramientas Incluidas](#-herramientas-incluidas)
7. [Comandos y Alias del Sistema](#-comandos-y-alias-del-sistema)
8. [Actualización del Sistema](#-actualización-del-sistema)
9. [Contribuir al Proyecto](#-contribuir-al-proyecto)
10. [Roadmap](#-roadmap)
11. [Advertencia Legal](#-advertencia-legal)
12. [Licencia](#-licencia)
13. [Créditos y Agradecimientos](#-créditos-y-agradecimientos)
14. [Contacto y Redes](#-contacto-y-redes)

---

## 📖 Descripción del Proyecto

**ProtoSec OS** es una distribución GNU/Linux live avanzada y premium basada en el entorno estable de **Debian 12 Bookworm (stable, 64-bit)** y en el escritorio gráfico **KDE Plasma**. El proyecto nace para solucionar una necesidad crítica de los administradores y expertos en ciberseguridad modernos: la fragmentación de herramientas de diagnóstico y despliegue.

Tradicionalmente, un analista requiere sistemas orientados exclusivamente a la ofensiva (como *Kali Linux*), mientras que para desplegar infraestructura segura recurre a distribuciones puramente de servidor y bases de datos aisladas. **ProtoSec OS unifica estos tres pilares fundamentales en una sola experiencia híbrida**. El sistema está diseñado tanto para realizar auditorías e intrusiones controladas (pentesting), como para simular servidores de producción bastinados de alta carga y bases de datos transaccionales, relacionales y documentales.

Con una experiencia visual enriquecida tipo "hardened cyberpunk", ProtoSec OS dota a los terminales de una estética impresionante y micro-animaciones dinámicas optimizadas. Todo el ecosistema operativo —incluidos los diálogos en terminal basados en interfaces Whiptail interactivas (`protosec-tools` y `protosec-setup`) y la guía de hardening— se encuentra localizado **100% en español**, garantizando un control perfecto de la plataforma a profesionales e ingenieros de habla hispana.

---

## 🌟 Características Principales

| Categoría | Herramientas principales | Descripción |
| :--- | :--- | :--- |
| **Pentesting Ofensivo** | Metasploit, Nmap, Wireshark, Sqlmap, John the Ripper, Hydra | Suite completa para escaneo, enumeración, explotación y craqueo de credenciales en red. |
| **Análisis Defensivo** | AppArmor, AIDE, auditd, rkhunter, chkrootkit | Capas activas de monitorización de integridad del núcleo y control de ejecución de demonios. |
| **Bases de Datos** | MariaDB, PostgreSQL, MongoDB, Redis, DBeaver, pgAdmin | Motores locales configurados con interfaz administrativa integrada y CLI avanzados (`pgcli`, `mycli`). |
| **Servidor Web & DevOps** | Nginx, Apache2, Docker CE, Podman, Ansible, Cockpit | Suite DevOps de virtualización ágil, balanceo, monitoreo y consola web local unificada. |
| **VPN y Seguridad de Red** | WireGuard, OpenVPN, UFW (Firewall), Fail2Ban | Mecanismos criptográficos para cifrado de túneles y bloqueo automático de intrusiones en puertos. |
| **Ingeniería Inversa** | Ghidra, Radare2, Binwalk, Foremost | Plataformas de ingeniería inversa de código y análisis forense de ficheros y volcados de memoria. |

---

## 📸 Capturas de Pantalla

> [!NOTE]
> Las capturas de pantalla reales se añadirán de manera progresiva tras completarse la primera compilación de producción de la ISO híbrida en el repositorio. Los marcadores a continuación se actualizarán en `assets/wallpapers/` y `docs/screenshots/`:

*   **Escritorio KDE Plasma Tema ProtoSec**: Tema de escritorio oscuro profundo Breeze-Dark con sombras translúcidas, acentos verde brillante `#00FF41` e iconos Papirus-Dark.
*   **Prompt de Terminal Starship**: Prompt interactivo Konsole con ligaduras de fuentes tipográficas, visualización del estado de ramas Git y latencias.
*   **Menú Whiptail de Utilidades**: Interfaz de control en terminal lanzada mediante `protosec-tools` para automatizar arranque y parada de servidores y exploits.

---

## 💻 Requisitos del Sistema

| Componente | Requisito Mínimo | Requisito Recomendado |
| :--- | :--- | :--- |
| **Procesador (CPU)** | x86_64 dual-core a 2.0 GHz | x86_64 quad-core a 2.5 GHz o superior |
| **Memoria RAM** | 4 GB (Modo Live de prueba) | 8 GB (Uso estándar) / 16 GB (Servidores activos) |
| **Disco Duro (SSD)** | 30 GB (Instalación limpia) | 60 GB o superior en disco SSD de alta velocidad |
| **Gráficos** | Soporte OpenGL 2.0 (VM Integrada) | GPU dedicada con 2 GB VRAM para escritorio fluido |
| **Arranque** | UEFI de 64 bits o BIOS Legacy | UEFI de 64 bits con Secure Boot deshabilitado |

---

## 🚀 Instalación y Uso

### 7.1 — Descargar la ISO
Cuando la primera compilación final de producción esté disponible, descarga la imagen híbrida y su fichero checksum de integridad:
```bash
# Descargar la imagen ISO
wget https://github.com/jpscalero/protosec-os/releases/download/v1.0.0-alpha/ProtoSec-1.0-amd64.iso

# Comprobar la firma SHA256
sha256sum --check ProtoSec-1.0-amd64.iso.sha256
```

### 7.2 — Crear USB booteable
Escribe la ISO directamente a un dispositivo USB por bloques. En sistemas Linux:
```bash
# dd por bloques (reemplaza sdX por tu unidad USB real)
sudo dd if=ProtoSec-1.0-amd64.iso of=/dev/sdX bs=4M status=progress conv=fdatasync && sync
```

### 7.3 — Construir la ISO desde el Código Fuente
Puedes generar tu propia ISO híbrida personalizada de ProtoSec OS 1.0 en tu propio servidor o máquina host con Debian 12 Bookworm (stable):
```bash
# Instalar los componentes de live-build
sudo apt-get update && sudo apt-get install -y live-build debootstrap squashfs-tools xorriso

# Clonar y construir
git clone https://github.com/jpscalero/protosec-os.git
cd protosec-os
sudo chmod +x build.sh auto/config auto/build auto/clean config/hooks/live/*
sudo ./build.sh
```

---

## 🛠 Herramientas Incluidas

<details>
<summary>🔴 Pentesting y Auditoría de Seguridad (Haz click para expandir)</summary>

| Herramienta | Categoría | Descripción | Uso Básico |
| :--- | :--- | :--- | :--- |
| **Nmap** | Reconocimiento | Escáner de red avanzado y mapeador de puertos | `nmap -sV -sC -T4 ip` |
| **Wireshark** | Análisis de Tráfico | Analizador gráfico interactivo de tramas y protocolos | `wireshark &` |
| **Metasploit** | Explotación | Framework industrial para desarrollo de exploits y payloads | `msfconsole` |
| **Sqlmap** | Vulnerabilidades | Motor automático para la detección y explotación de inyección SQL | `sqlmap -u url --dbs` |
| **Ghidra** | Ingeniería Inversa | Suite de ingeniería inversa de binarios de la NSA basada en Java | `ghidra &` |
| **John the Ripper**| Criptoanálisis | Descifrador de hashes criptográficos mediante fuerza bruta | `john --wordlist=dict.txt hashes` |
| **Bettercap** | Redes | Framework completo para ataques Man-in-the-Middle | `bettercap` |

</details>

<details>
<summary>🟠 Motores y Clientes de Bases de Datos (Haz click para expandir)</summary>

| Herramienta | Categoría | Descripción | Uso Básico |
| :--- | :--- | :--- | :--- |
| **MariaDB** | SQL RDBMS | Servidor relacional ligero compatible con MySQL nativo | `sudo systemctl start mariadb` |
| **PostgreSQL** | SQL RDBMS | Motor relacional de nivel empresarial con soporte JSON | `sudo systemctl start postgresql` |
| **MongoDB** | NoSQL Documental | Base de datos NoSQL basada en documentos JSON/BSON | `sudo systemctl start mongod` |
| **Redis** | NoSQL Key-Value | Almacenamiento en caché en memoria y estructura de datos | `sudo systemctl start redis-server` |
| **DBeaver CE** | Interfaz Gráfica | Administrador universal gráfico SQL/NoSQL | `dbeaver &` |
| **MongoDB Compass**| Interfaz Gráfica | Cliente visual oficial para la consulta de bases MongoDB | `mongodb-compass &` |

</details>

<details>
<summary>🟢 Infraestructura, Servidores y DevOps (Haz click para expandir)</summary>

| Herramienta | Categoría | Descripción | Uso Básico |
| :--- | :--- | :--- | :--- |
| **Nginx** | Servidor Web | Servidor web de alto rendimiento y proxy inverso seguro | `sudo systemctl start nginx` |
| **Docker CE** | Contenedores | Suite de contenedores ágiles y compose multihilo | `docker run --rm hello-world` |
| **Ansible** | Automatización | Motor de automatización y orquestación sin agentes | `ansible-playbook -i hosts play.yml` |
| **Cockpit** | Panel Web | Consola administrativa web integrada para gestión de host | `sudo systemctl start cockpit` |
| **Grafana** | Monitorización | Plataforma analítica interactiva y cuadros de mandos | `sudo systemctl start grafana-server`|
| **WireGuard** | VPN Criptográfica | Protocolo de túnel seguro VPN integrado en el kernel | `sudo wg-quick up wg0` |

</details>

---

## ⌨️ Comandos y Alias del Sistema

Para maximizar tu eficiencia de terminal en Konsole con Zsh, se cargan por defecto los siguientes atajos de comando inteligentes (`alias`):

| Alias | Comando Real | Descripción |
| :--- | :--- | :--- |
| `scan` | `nmap -sV -sC -T4` | Escaneo rápido de red con detección de versión y scripts seguros. |
| `ports` | `ss -tulpn` | Muestra de forma numerada todos los puertos de escucha y sus PIDs. |
| `tools` | `protosec-tools` | Ejecuta el menú de utilidades y bases de datos local. |
| `setup` | `protosec-setup` | Arranca el asistente administrativo de hardening post-instalación. |
| `ip-public` | `curl -s https://ifconfig.me` | Consulta veloz de la IP externa a través de terminal. |
| `docker-clean`| `docker system prune -af` | Purgado profundo de imágenes y contenedores huérfanos. |
| `db-status` | `sudo systemctl status mariadb postgresql mongod redis-server` | Estado general consolidado de todos los motores de base de datos. |

---

## 🔄 Actualización del Sistema

Puedes mantener todo tu sistema operativo, librerías Python y bases de datos de exploits actualizados al último día mediante el comando de casa integrado:
```bash
sudo protosec-update
```
Este script realiza de manera automática la actualización de paquetes Debian (`apt-get dist-upgrade`), las herramientas de pip/gem y sincroniza los repositorios de `/opt/` (SecLists, Exploit-DB, etc.).

---

## 🤝 Contribuir al Proyecto

¡Agradecemos enormemente cualquier aporte de la comunidad de ciberseguridad! Para proponer mejoras:
1.  Haz un **Fork** del repositorio.
2.  Crea tu rama de desarrollo dedicada: `git checkout -b feature/nueva-herramienta`.
3.  Escribe tus commits siguiendo el formato de **Conventional Commits** (ejemplo: `feat: add subfinder to pentesting list`).
4.  Asegúrate de que el código supera los tests del linter de Bash (`shellcheck`).
5.  Abre un **Pull Request** detallando tus cambios a la rama `develop` de este repositorio.

Revisa nuestra [Guía de Contribución](CONTRIBUTING.md) para más detalles.

---

## 🗺️ Roadmap

- [x] **v1.0.0-alpha** (Base Debian 12 Bookworm, KDE Plasma visual suite, 5 hooks estables de compilación, scripts administrativos Whiptail).
- [ ] **v1.1.0** (Integración completa del instalador gráfico Calamares en el menú principal, inclusión de utilidades OSINT avanzadas de Python3).
- [ ] **v1.2.0** (Soporte para modo Headless alternativo sin entorno gráfico para despliegues ligeros en servidores remotos).
- [ ] **v2.0.0** (Compilación de un kernel Linux personalizado reforzado frente a vulnerabilidades y suite de herramientas propias de ProtoSec).

---

## ⚖️ Advertencia Legal

> [!CAUTION]
> **USO ÉTICO Y LEGAL OBLIGATORIO**: Todas las herramientas de pentesting, exploits y utilidades de red contenidas en **ProtoSec OS** han sido desarrolladas y empaquetadas exclusivamente para fines educativos, auditorías de seguridad debidamente autorizadas y protección de sistemas propios. Realizar análisis de intrusión y escaneos de puertos contra infraestructuras ajenas sin autorización explícita y por escrito de los propietarios legales es estrictamente **ilegal** y constituye un delito penal en la mayoría de jurisdicciones. Los desarrolladores e integrantes del proyecto ProtoSec OS declinan cualquier responsabilidad por daños derivados del uso inapropiado de esta plataforma. El operador asume toda la responsabilidad legal por sus acciones.

---

## 📄 Licencia

ProtoSec OS © 2026 **jpscalero**

Este proyecto de distribución Linux se distribuye bajo la licencia pública **GNU General Public License v3.0**. Consulta el archivo [LICENSE](LICENSE) para acceder al texto completo y los términos de atribución y modificación.

---

## 💖 Créditos y Agradecimientos

- Al equipo de **Debian Project** por proveer la distribución base más estable, robusta y confiable del ecosistema Linux.
- Al equipo de desarrollo de **live-build** por sus herramientas flexibles de empaquetamiento y personalización de imágenes de disco.
- A todos los creadores de software libre y herramientas de seguridad integradas en este arsenal por su inestimable aporte al desarrollo de la ciberseguridad global.

---

## ✉️ Contacto y Redes

Para estar al tanto de las actualizaciones de la distribución y contactar al mantenedor:
- **Perfil de GitHub**: [github.com/jpscalero](https://github.com/jpscalero)
- **Perfil de GitLab**: [gitlab.com/jpscalero](https://gitlab.com/jpscalero)
