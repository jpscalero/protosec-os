# Guía de Contribución / Contributing Guide (ProtoSec OS)

[English Version Below](#english-version)

---

## 🇪🇸 Versión en Español

¡Gracias por tu interés en colaborar con **ProtoSec OS**! Queremos hacer de esta distribución la plataforma defensiva y ofensiva más completa e intuitiva. A continuación, te explicamos cómo puedes participar de manera efectiva.

### 📋 Cómo Contribuir

#### 1. Reportar Errores (Bugs)
Si encuentras un fallo en los scripts de construcción (`build.sh`), fallos de dependencias en los hooks, o errores lógicos:
*   Busca en la lista de *Issues* activos por si alguien ya lo ha reportado.
*   Si es nuevo, abre un Issue utilizando el template **Reporte de Errores (Bug)**.
*   Asegúrate de incluir logs detallados (los de `/opt/protosec-build/build.log`) y detalles de tu máquina anfitriona.

#### 2. Solicitar Nuevas Herramientas (Tool Requests)
Si echas en falta alguna utilidad útil de pentesting, administración de bases de datos o servidor:
*   Abre un Issue con el template **Solicitud de Herramientas (Tool Request)**.
*   Indica detalladamente por qué consideras valiosa su incorporación y cómo se instalaría en el entorno chroot.

#### 3. Proponer Mejoras de Código
Si deseas realizar modificaciones en los scripts o archivos de configuración:
1.  Haz un **Fork** del repositorio.
2.  Crea una rama descriptiva para tu cambio:
    *   `feature/nombre-de-la-mejora` para nuevas características.
    *   `bugfix/nombre-del-fallo` para corregir errores.
    *   `docs/nombre-de-la-guia` para cambios de documentación.
3.  Implementa tus cambios respetando los estándares de código.
4.  Haz commits claros utilizando la convención **Conventional Commits** (ver abajo).
5.  Asegúrate de que pasa el validador estático de ShellCheck.
6.  Envía un **Pull Request / Merge Request** enlazando el Issue correspondiente.

### ⚙️ Estándares y Convenciones

*   **Estilo del código**: Las variables y nombres de funciones en los scripts Bash deben declararse en minúsculas y estilo `snake_case` (ej. `mi_variable_local`).
*   **Seguridad**: Todas las variables Bash utilizadas dentro de comandos deben estar debidamente entrecomilladas (`"$mi_variable"`) para evitar inyecciones de código.
*   **Comentarios**: Todos los comentarios explicativos y la documentación técnica deben redactarse estrictamente en **español**.
*   **Shebang**: Todo script Bash o archivo hook chroot debe comenzar obligatoriamente con el shebang `#!/bin/bash` o `#!/usr/bin/env bash`.

### 📝 Formato de Mensajes de Commit (Conventional Commits)

Los commits del proyecto deben estructurarse de la siguiente manera: `<tipo>: <descripción breve en minúsculas>`

Tipos permitidos:
*   `feat`: Una nueva funcionalidad o herramienta inyectada en la ISO.
*   `fix`: Corrección de un bug en un script o hook.
*   `docs`: Cambios o ampliaciones de documentación en archivos Markdown.
*   `style`: Cambios de formato o espaciado en scripts (sin cambios lógicos).
*   `refactor`: Modificaciones de código para mejorar eficiencia o legibilidad.
*   `test`: Añadir o corregir workflows CI/CD y verificaciones.
*   `chore`: Tareas administrativas menores, dependencias o versiones.

*Ejemplo: `feat: add subfinder compilation in hook 0030`*

---

<a name="english-version"></a>
## 🇬🇧 English Version

Thank you for your interest in contributing to **ProtoSec OS**! We want to make this distribution the most comprehensive and intuitive defensive/offensive platform. Below you will find out how you can effectively participate.

### 📋 How to Contribute

#### 1. Reporting Bugs
If you find a bug in the build scripts (`build.sh`), dependency failures in chroot hooks, or logical errors:
*   Search active *Issues* to see if someone has already reported it.
*   If new, open an Issue using the **Bug Report** template.
*   Make sure to include detailed logs (from `/opt/protosec-build/build.log`) and your host specifications.

#### 2. Requesting New Tools (Tool Requests)
If you miss any useful pentesting, database, or server utility:
*   Open an Issue using the **Tool Request** template.
*   Explain in detail why you consider its incorporation valuable and how it should be installed in the chroot.

#### 3. Proposing Code Improvements
If you want to modify scripts or configuration files:
1.  **Fork** the repository.
2.  Create a descriptive branch for your changes:
    *   `feature/feature-name` for new features.
    *   `bugfix/bug-name` for bug fixes.
    *   `docs/guide-name` for documentation improvements.
3.  Implement your changes respecting the project's code standards.
4.  Make clear commits using the **Conventional Commits** standard (see below).
5.  Ensure ShellCheck passes without warnings or errors.
6.  Open a **Pull Request / Merge Request** linking to the relevant Issue.

### ⚙️ Standards and Conventions

*   **Code Style**: Bash variables and function names must be declared in lowercase using `snake_case` (e.g. `my_local_variable`).
*   **Security**: All Bash variables used inside commands must be properly quoted (`"$my_variable"`) to prevent script injections.
*   **Comments**: All explanatory comments and technical documentation must be written strictly in **Spanish**.
*   **Shebang**: All Bash scripts or chroot hooks must start with `#!/bin/bash` or `#!/usr/bin/env bash`.

### 📝 Commit Message Format (Conventional Commits)

Commits must be structured as follows: `<type>: <short description in lowercase>`

Allowed types:
*   `feat`: A new feature or tool injected into the ISO.
*   `fix`: Bugfix in a script or hook.
*   `docs`: Changes or additions to Markdown documentation.
*   `style`: Code formatting changes (no logical alterations).
*   `refactor`: Code changes to improve efficiency or readability.
*   `test`: Add or fix CI/CD pipelines and structural checks.
*   `chore`: Minor administrative tasks, dependencies, or releases.

*Example: `feat: add subfinder compilation in hook 0030`*
