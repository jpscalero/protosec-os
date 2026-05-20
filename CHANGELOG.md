# Registro de Cambios (Changelog) — ProtoSec OS

Todos los cambios notables en este proyecto serán documentados en este archivo.

El formato se basa en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/) y este proyecto se adhiere a [SemVer (Versionado Semántico)](https://semver.org/lang/es/).

---

## [1.0.0-alpha] - 2026-05-20

### Añadido (Added)
*   **Base del Sistema**: Inyección de Debian 12 Bookworm (amd64) estable como núcleo del sistema live-build con soporte UEFI e ISO-hybrid.
*   **Identidad Visual**:
    *   Escritorio completo KDE Plasma 5 con tema global oscuro y detalles en verde vibrante (`#00FF41`).
    *   Tema visual SDDM de ProtoSec personalizado con fondo interactivo.
    *   Generador dinámico de fondo de pantalla Python (`generate-wallpaper.py`) simulando lluvia digital Matrix con logo.
    *   Konsole personalizada con tipografía Fira Code y paleta optimizada para legibilidad.
*   **Línea de Comandos**: Oh-My-Zsh inyectado de forma global con autocompletado y resaltado de sintaxis, prompt personalizado a través de Starship en color verde y naranja, e información extendida vía fastfetch al iniciar.
*   **Pentesting Arsenal**:
    *   Nativos APT: Nmap, masscan, sqlmap, john, hashcat, crunch, medusa, hydra, ettercap-graphical, Sleuthkit, foremost, binwalk, wireshark y tshark.
    *   Instalación externa: Metasploit, Ghidra, OWASP ZAP, ligolo-ng, bettercap, subfinder, ffuf, feroxbuster, Gobuster, evil-winrm, volatility3, theHarvester, sherlock, social-engineer-toolkit y chisel.
    *   Diccionarios locales: `rockyou.txt` descomprimido y clonación shallow de `SecLists`.
    *   Integración de searchsploit en `/usr/local/bin/` enlazando `/opt/exploitdb/`.
*   **Bases de Datos**:
    *   Servidores: MariaDB, PostgreSQL, Redis y SQLite.
    *   Clientes de consola: mycli, pgcli y usql.
    *   Clientes de escritorio: DBeaver CE y MongoDB Compass.
*   **Servidores e Infraestructura**:
    *   Contenedores: Docker CE y Podman.
    *   Servidores Web: Nginx y Apache2.
    *   DevOps: Jenkins, Gitea y Traefik.
    *   VPN: WireGuard con asistente automatizado.
    *   Administración: Cockpit panel en el puerto 9090.
*   **Scripts de Sistema**:
    *   `protosec-tools`: Interfaz interactiva Whiptail con 10 categorías en español para arrancar servicios y ejecutar utilidades ofensivas/defensivas.
    *   `protosec-setup`: Asistente interactivo en español para endurecimiento del sistema (sshd_config, UFW firewall, Fail2Ban, claves WireGuard, base de datos).
    *   `protosec-update`: Script automatizado con registro en `/var/log/` para actualizar paquetes del sistema, gemas de Ruby, módulos pip3 y repositorios git locales.
*   **CI/CD**:
    *   GitHub Workflows (`shellcheck.yml`, `build-check.yml`, `release.yml`).
    *   GitLab Pipeline (`.gitlab-ci.yml`).
    *   Templates de issues y Merge/Pull Requests configurados para ambas plataformas.
*   **Instalación**: Integración del instalador gráfico Calamares con branding y diapositivas ProtoSec en español.
