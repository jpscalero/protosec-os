#!/bin/bash
# =============================================================================
# ProtoSec OS 1.0 — Configuración de Bash (.bashrc)
# Archivo de configuración personalizado para el shell Bash
# =============================================================================

# --- Si no es una sesión interactiva, no hacer nada ---
case $- in
    *i*) ;;
      *) return;;
esac

# =============================================================================
# HISTORIAL
# =============================================================================
# Tamaño grande del historial para no perder comandos útiles
HISTSIZE=10000
HISTFILESIZE=20000
# No guardar líneas duplicadas ni líneas que empiecen con espacio
HISTCONTROL=ignoreboth:erasedups
# Añadir al historial en vez de sobreescribir
shopt -s histappend
# Guardar comandos multilínea en una sola entrada
shopt -s cmdhist

# =============================================================================
# OPCIONES DEL SHELL
# =============================================================================
# Actualizar las variables LINES y COLUMNS tras cada comando
shopt -s checkwinsize
# Permitir patrones glob extendidos
shopt -s extglob
# Corregir errores menores en cd
shopt -s cdspell
# Activar ** para búsqueda recursiva en glob
shopt -s globstar 2>/dev/null

# =============================================================================
# PROMPT PERSONALIZADO — Colores ProtoSec
# =============================================================================
# Colores: verde (#00FF41), naranja (#FF6B35)
if [ "$(id -u)" -eq 0 ]; then
    # Prompt para root — naranja
    PS1='\[\e[1;33m\]┌──[\[\e[1;31m\]\u\[\e[1;33m\]@\[\e[0;32m\]\h\[\e[1;33m\]]─[\[\e[0;36m\]\w\[\e[1;33m\]]\n└──╼ \[\e[1;31m\]# \[\e[0m\]'
else
    # Prompt para usuario normal — verde ProtoSec
    PS1='\[\e[1;32m\]┌──[\[\e[0;32m\]\u\[\e[1;32m\]@\[\e[0;32m\]\h\[\e[1;32m\]]─[\[\e[0;36m\]\w\[\e[1;32m\]]\n└──╼ \[\e[0;32m\]$ \[\e[0m\]'
fi

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
# AUTOCOMPLETADO
# =============================================================================
# Activar autocompletado de bash si está disponible
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# =============================================================================
# MENSAJE DE BIENVENIDA
# =============================================================================
echo -e "\e[0;32m[ProtoSec OS]\e[0m Sesión bash iniciada — \e[0;33mHack. Analyze. Deploy.\e[0m"
echo ""
