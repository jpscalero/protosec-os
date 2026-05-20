## 📋 Descripción de los Cambios
Proporcione un resumen detallado de las modificaciones realizadas en este Pull Request y por qué son necesarias.

## 🎯 Tipo de Cambio
- [ ] 🐛 Solución de un Bug (Bugfix que soluciona un problema sin romper otras características)
- [ ] 🚀 Nueva Característica (Feature que añade funcionalidad al sistema)
- [ ] 📚 Documentación (Mejoras en archivos Markdown, comentarios o guías de docs/)
- [ ] ⚙️ Refactorización / Optimización de código (Sin cambios de comportamiento)
- [ ] 🛡️ Hardening / Seguridad adicional

## 🧪 Pruebas y Validación Realizadas
Describa cómo ha probado las modificaciones. Indique qué comandos ha ejecutado o si ha construido la ISO de pruebas para validar chroot hooks:
- [ ] Pruebas estáticas con `bash -n` o ShellCheck pasadas sin errores.
- [ ] Validación de la estructura del sistema de ficheros de live-build.
- [ ] Simulación o ejecución en una instalación live/VM.

## 🏁 Lista de Verificación (Checklist)
Antes de enviar el PR, asegúrese de marcar lo siguiente:
- [ ] Mi código sigue el estilo y estándares del proyecto (snake_case para variables, comentarios en español).
- [ ] He añadido o modificado la documentación correspondiente de la carpeta `docs/` si es aplicable.
- [ ] He actualizado el archivo `CHANGELOG.md` describiendo brevemente los cambios en la sección correspondiente.
- [ ] Mis cambios no provocan errores sintácticos ni fallos al invocar scripts de live-build en chroot.
