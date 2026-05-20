# Política de Seguridad — ProtoSec OS

## Resumen y Declaración de Compromiso

En el proyecto **ProtoSec OS**, nos tomamos muy en serio la seguridad de nuestra distribución y de los sistemas que la ejecutan. Al ser una plataforma orientada a la ciberseguridad defensiva y ofensiva, es vital que las utilidades inyectadas en la ISO y las configuraciones de endurecimiento (*hardening*) del sistema base permanezcan libres de fallos que puedan ser explotados por terceros.

Agradecemos enormemente las contribuciones y los reportes de la comunidad de investigadores de seguridad. Nos comprometemos a responder con la mayor brevedad posible para mitigar cualquier fallo de seguridad detectado.

## Versiones Soportadas

Actualmente, damos soporte exclusivo y activo a la rama principal de producción:

| Versión | Soportada | Estado |
|---------|-----------|--------|
| v1.0.x  | ✅ Sí      | Versión Estable Activa (Basada en Debian 12 Bookworm) |
| < v1.0  | ❌ No      | Versiones de Desarrollo / Alphas Descatalogadas |

## Cómo Reportar una Vulnerabilidad

Si descubres una vulnerabilidad de seguridad (como un fallo de escalada de privilegios en nuestros scripts locales, contraseñas residuales en la ISO live, fallos criptográficos en la generación de claves WireGuard o SSH, etc.):

1.  **NO abras un Issue público** en GitHub ni GitLab.
2.  Envía un reporte detallado de forma confidencial y privada al correo de los mantenedores: **jpscalero@outlook.com**
3.  En tu correo, incluye la mayor cantidad de información posible:
    *   Una descripción detallada de la vulnerabilidad.
    *   Pasos detallados para reproducir el fallo (PoC).
    *   El impacto potencial en el sistema host o usuario final.
    *   Si es posible, propuestas para solucionarlo.

## Tiempo de Respuesta y Proceso

*   **Acuse de Recibo**: Responderemos a tu correo confirmando la recepción del reporte en un plazo máximo de **48 horas**.
*   **Evaluación Inicial**: Analizaremos el impacto y la viabilidad del fallo en un plazo máximo de **7 días hábiles**.
*   **Divulgación Responsable**: Solicitamos un margen de **30 días** desde que confirmamos el reporte para desarrollar, validar e inyectar el parche correspondiente antes de que realices una divulgación pública. Creemos firmemente en el principio de divulgación coordinada de vulnerabilidades para proteger a nuestros usuarios.

## Lo que NO debe reportarse como Vulnerabilidad

Al ser una distribución de auditoría y pentesting, el sistema incluye por diseño herramientas que realizan análisis agresivos de red, sniffing de tráfico, fuerza bruta y exploits (como Metasploit o John).
*   Las alertas o falsos positivos de antivirus sobre los directorios `/usr/share/wordlists/` o carpetas de exploit-db (`/opt/exploitdb/`) son comportamientos esperados y **no deben ser reportados** como vulnerabilidad.
*   Los puertos abiertos que actives voluntariamente (como el puerto de MariaDB o Jenkins) no son vulnerabilidades, sino servicios del sistema que deben administrarse según el caso.
