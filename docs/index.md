# Centro de Documentación Oficial — ProtoSec OS

Bienvenido a la documentación oficial y profesional de **ProtoSec OS**. Esta distribución Linux avanzada y modular ha sido construida para servir como la plataforma definitiva en auditorías de seguridad, administración de bases de datos críticas y despliegue ágil en entornos DevOps.

---

## 🚀 Filosofía del Proyecto

A diferencia de otras distribuciones orientadas exclusivamente al análisis ofensivo, **ProtoSec OS** unifica tres pilares esenciales de la infraestructura tecnológica actual en una única solución unificada y altamente estilizada sobre **Debian 12 Bookworm (stable)** con el entorno **KDE Plasma**:

```
                  ┌─────────────────────────────────┐
                  │          PROTOSEC OS            │
                  └────────────────┬────────────────┘
                                   │
         ┌─────────────────────────┼─────────────────────────┐
         ▼                         ▼                         ▼
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│ PENTESTING      │       │ BASES DE DATOS  │       │ SERVIDORES      │
│ Y AUDITORÍA     │       │ Y DATABASES     │       │ Y DEVOPS        │
└─────────────────┘       └─────────────────┘       └─────────────────┘
```

> [!NOTE]
> Todos los scripts del sistema, configuraciones, asistentes interactivos y menús se encuentran implementados íntegramente en **español**, con un diseño visual coherente inspirado en la estética terminal cyberpunk.

---

## 📚 Mapa de la Documentación

Navega a través de los diferentes manuales y guías detalladas para aprender a exprimir al máximo tu sistema:

*   **[Guía de Compilación e Integración](building.md)**: Aprende cómo configurar un entorno Debian anfitrión (`host`) y construir la ISO híbrida desde cero mediante el sistema `live-build` y los scripts personalizados del proyecto.
*   **[Guía de Instalación Avanzada](installation.md)**: Instrucciones paso a paso para quemar la ISO en dispositivos físicos USB, arrancar en modo BIOS/UEFI, instalar el sistema de forma desatendida o mediante el instalador gráfico **Calamares**, y virtualizar en entornos VMware y VirtualBox.
*   **[Hardening y Bastionado del Sistema](configuration/hardening.md)**: Manual detallado para asegurar tu instalación de ProtoSec OS en entornos de producción. Incluye la configuración avanzada de **UFW**, **Fail2Ban**, AppArmor, integridad del sistema con **AIDE** y el bastionado criptográfico del servidor **OpenSSH**.

---

## 🛠️ Herramientas Propias de ProtoSec OS

Para agilizar el uso del sistema tanto en modo Live como una vez instalado, se incluyen utilidades preconfiguradas directamente en el `PATH`:

| Herramienta | Comando | Descripción |
| :--- | :--- | :--- |
| **Menú de Arsenal** | `protosec-tools` | Lanzador interactivo en terminal basado en `whiptail` para acceder a herramientas y controlar el estado de servicios de bases de datos y servidores. |
| **Asistente de Hardening** | `protosec-setup` | Script guiado para securizar el sistema post-instalación, gestionar usuarios administradores, configurar la red y desplegar el cortafuegos y VPNs. |
| **Actualizador Inteligente** | `protosec-update` | Utilidad centralizada para actualizar el sistema base de Debian, bases de datos de firmas locales (como freshclam), paquetes de `pip` (Python) y repositorios clonados en `/opt/`. |

---

## 📋 Requisitos Mínimos y Recomendados

Para garantizar una experiencia fluida y reactiva en tu entorno de trabajo, asegúrate de cumplir con los siguientes requisitos:

> [!IMPORTANT]
> - **Procesador (CPU)**: Arquitectura `x86_64` de 64 bits. Mínimo Dual-Core 2.0 GHz (Recomendado Quad-Core 2.5 GHz o superior).
> - **Memoria RAM**: Mínimo **4 GB** en modo Live; se recomiendan **8 GB** o más para uso general, y **16 GB** si se ejecutan múltiples motores de bases de datos locales.
> - **Almacenamiento (SSD)**: Mínimo **30 GB** para instalación limpia; recomendado **60 GB** o más con tecnología de estado sólido (SSD) para cargas de bases de datos complejas.
