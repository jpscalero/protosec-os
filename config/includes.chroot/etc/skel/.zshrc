# =============================================================================
# ProtoSec OS 1.0 — Configuración de Zsh (.zshrc)
# Archivo de configuración personalizado para el shell Zsh
# Configurado por ProtoSec OS 1.0
# =============================================================================

# =============================================================================
# OH-MY-ZSH
# =============================================================================
# Ruta de instalación del sistema (paquete Debian)
export ZSH=/usr/share/oh-my-zsh

# Tema deshabilitado — se usa Starship como prompt
ZSH_THEME=""

# Plugins activos
plugins=(
    git
    sudo
    zsh-autosuggestions
    zsh-syntax-highlighting
    colored-man-pages
    command-not-found
    docker
    python
    history
)

# Cargar Oh-My-Zsh (si está instalado)
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
    source "$ZSH/oh-my-zsh.sh"
fi

# =============================================================================
# STARSHIP PROMPT
# =============================================================================
# Inicializar Starship como prompt (reemplaza al tema de Oh-My-Zsh)
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi

# =============================================================================
# HISTORIAL
# =============================================================================
HISTSIZE=10000
SAVEHIST=20000
HISTFILE=~/.zsh_history
# Compartir historial entre sesiones
setopt SHARE_HISTORY
# No guardar duplicados
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
# Añadir al historial inmediatamente
setopt INC_APPEND_HISTORY
# Eliminar espacios extra del historial
setopt HIST_REDUCE_BLANKS
# No guardar comandos que empiecen con espacio
setopt HIST_IGNORE_SPACE

# =============================================================================
# OPCIONES DE ZSH
# =============================================================================
# Corrección automática de comandos
setopt CORRECT
# Permitir cd sin escribir cd
setopt AUTO_CD
# Notificar inmediatamente al terminar un trabajo en segundo plano
setopt NOTIFY
# No hacer beep
unsetopt BEEP

# =============================================================================
# VARIABLES DE ENTORNO
# =============================================================================
export EDITOR='nano'
export VISUAL='nano'
export PAGER='less'
export LANG='es_ES.UTF-8'
export LC_ALL='es_ES.UTF-8'
export TERM='xterm-256color'

# Rutas adicionales para herramientas de seguridad
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH"

# Configuración de Go (si está instalado)
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin:/usr/local/go/bin"

# Configuración de Rust/Cargo (si está instalado)
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# =============================================================================
# COLORES PARA PÁGINAS DE MANUAL (man)
# =============================================================================
export LESS_TERMCAP_mb=$'\e[1;32m'      # Parpadeo — verde
export LESS_TERMCAP_md=$'\e[1;32m'      # Negrita — verde
export LESS_TERMCAP_me=$'\e[0m'         # Fin de modo
export LESS_TERMCAP_so=$'\e[01;33m'     # Inicio de standout — amarillo
export LESS_TERMCAP_se=$'\e[0m'         # Fin de standout
export LESS_TERMCAP_us=$'\e[1;36m'      # Inicio de subrayado — cyan
export LESS_TERMCAP_ue=$'\e[0m'         # Fin de subrayado
export LESS='-R'

# =============================================================================
# ALIAS — Herramientas ProtoSec
# =============================================================================

# --- Escaneo y reconocimiento ---
alias scan='sudo nmap -sV -sC -O'
alias fullscan='sudo nmap -sV -sC -O -A -T4 --script=default,vuln'
alias ports='sudo ss -tlnp'
alias listen='sudo netstat -tlnp'

# --- Información de red ---
alias myip='echo "IP Local: $(hostname -I | awk "{print \$1}")" && echo "IP Pública: $(curl -s ifconfig.me)"'

# --- Información del sistema ---
alias sysinfo='fastfetch || neofetch'

# --- Estado de bases de datos ---
alias dbstatus='echo "=== Estado de Bases de Datos ==="; for svc in mariadb postgresql redis-server mongod; do printf "%-15s: " "$svc"; systemctl is-active $svc 2>/dev/null || echo "inactivo"; done'

# --- Gestión de servicios ---
alias serverup='sudo systemctl start nginx mariadb postgresql redis-server'
alias serverdown='sudo systemctl stop nginx mariadb postgresql redis-server'

# --- VPN ---
alias vpnup='sudo wg-quick up wg0'
alias vpndown='sudo wg-quick down wg0'

# --- Actualización del sistema ---
alias update='sudo protosec-update'

# --- Utilidades generales ---
alias cls='clear'
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias mkdir='mkdir -pv'
alias wget='wget -c'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

# --- Directorios rápidos ---
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# =============================================================================
# FUNCIONES ÚTILES
# =============================================================================

# Extraer archivos comprimidos de cualquier formato
extraer() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.tar.xz)    tar xJf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' no se puede extraer con esta función" ;;
        esac
    else
        echo "'$1' no es un archivo válido"
    fi
}

# Crear directorio y entrar en él
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# =============================================================================
# AUTOCOMPLETADO MEJORADO
# =============================================================================
# Activar el sistema de autocompletado de zsh
autoload -Uz compinit
compinit

# Autocompletado insensible a mayúsculas/minúsculas
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Menú de selección para autocompletado
zstyle ':completion:*' menu select

# Colores en las sugerencias de autocompletado
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Agrupar las sugerencias por categoría
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- Sin coincidencias --%f'

# Cache de autocompletado para mayor velocidad
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zcompcache"

# =============================================================================
# ATAJOS DE TECLADO
# =============================================================================
# Modo emacs para la edición de línea
bindkey -e

# Búsqueda en historial con flechas arriba/abajo
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Inicio y fin de línea
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# Suprimir
bindkey '^[[3~' delete-char

# =============================================================================
# MENSAJE DE BIENVENIDA
# =============================================================================
echo -e "\e[0;32m[ProtoSec OS]\e[0m Sesión zsh iniciada — \e[0;33mHack. Analyze. Deploy.\e[0m"
echo ""

# Configurado por ProtoSec OS 1.0
