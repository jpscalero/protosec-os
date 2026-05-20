#!/bin/bash
# =============================================================================
# ProtoSec OS 1.0 — Script de MOTD dinámico
# Se ejecuta al iniciar sesión para mostrar información del sistema
# =============================================================================

# --- Colores ANSI ---
VERDE='\e[0;32m'
ROJO='\e[0;31m'
AMARILLO='\e[1;33m'
NARANJA='\e[0;33m'
CYAN='\e[0;36m'
BLANCO='\e[1;37m'
GRIS='\e[0;37m'
RESET='\e[0m'

# --- Función auxiliar: comprobar estado de un servicio ---
estado_servicio() {
    local nombre="$1"
    local servicio="$2"
    if systemctl is-active --quiet "$servicio" 2>/dev/null; then
        printf "  ${VERDE}●${RESET} %-20s ${VERDE}activo${RESET}\n" "$nombre"
    else
        printf "  ${ROJO}●${RESET} %-20s ${ROJO}inactivo${RESET}\n" "$nombre"
    fi
}

# --- Logo ASCII ProtoSec ---
echo -e "${VERDE}"
cat << 'EOF'
 ██████╗ ██████╗  ██████╗ ████████╗ ██████╗ ███████╗███████╗ ██████╗
 ██╔══██╗██╔══██╗██╔═══██╗╚══██╔══╝██╔═══██╗██╔════╝██╔════╝██╔════╝
 ██████╔╝██████╔╝██║   ██║   ██║   ██║   ██║███████╗█████╗  ██║     
 ██╔═══╝ ██╔══██╗██║   ██║   ██║   ██║   ██║╚════██║██╔══╝  ██║     
 ██║     ██║  ██║╚██████╔╝   ██║   ╚██████╔╝███████║███████╗╚██████╗
 ╚═╝     ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚══════╝╚══════╝ ╚═════╝
EOF
echo -e "${RESET}"

# --- Información del sistema ---
echo -e " ${BLANCO}ProtoSec OS 1.0${RESET} — ${NARANJA}Hack. Analyze. Deploy.${RESET}"
echo -e " ${GRIS}─────────────────────────────────────────────────────────────────${RESET}"
echo ""
echo -e "  ${CYAN}Fecha y hora:${RESET}   $(date '+%A, %d de %B de %Y — %H:%M:%S')"
echo -e "  ${CYAN}IP local:${RESET}       $(hostname -I 2>/dev/null | awk '{print $1}' || echo 'no disponible')"
echo -e "  ${CYAN}Kernel:${RESET}         $(uname -r)"
echo -e "  ${CYAN}Uptime:${RESET}         $(uptime -p 2>/dev/null | sed 's/up //' || uptime | awk '{print $3,$4}' | sed 's/,//')"
echo ""

# --- Estado de servicios ---
echo -e " ${BLANCO}Estado de servicios:${RESET}"
echo -e " ${GRIS}───────────────────────────────${RESET}"

# Servidor Web: comprobar nginx o apache2
if systemctl is-active --quiet nginx 2>/dev/null; then
    estado_servicio "Servidor Web" "nginx"
elif systemctl is-active --quiet apache2 2>/dev/null; then
    estado_servicio "Servidor Web" "apache2"
else
    # Ninguno activo, mostrar nginx como referencia
    estado_servicio "Servidor Web" "nginx"
fi

# Base de Datos: comprobar mariadb o postgresql
if systemctl is-active --quiet mariadb 2>/dev/null; then
    estado_servicio "Base de Datos" "mariadb"
elif systemctl is-active --quiet postgresql 2>/dev/null; then
    estado_servicio "Base de Datos" "postgresql"
else
    estado_servicio "Base de Datos" "mariadb"
fi

# VPN WireGuard
estado_servicio "VPN (WireGuard)" "wg-quick@wg0"

# Docker
estado_servicio "Docker" "docker"

# SSH
estado_servicio "SSH" "ssh"

echo ""

# --- Frase motivacional aleatoria ---
FRASES=(
    "La seguridad no es un producto, es un proceso. — Bruce Schneier"
    "El único sistema verdaderamente seguro es aquel que está apagado. — Gene Spafford"
    "Hackear es el arte de encontrar lo inesperado."
    "La mejor defensa es un buen ataque... controlado y ético."
    "Un pentester no rompe sistemas, los mejora."
    "La ciberseguridad es responsabilidad de todos, no solo del equipo de TI."
    "Cada vulnerabilidad encontrada es una oportunidad de mejora."
    "No confíes, verifica. Zero Trust es el camino."
    "El conocimiento es la herramienta más poderosa del hacker ético."
    "En ciberseguridad, la paranoia es una virtud profesional."
)
INDICE=$((RANDOM % ${#FRASES[@]}))
echo -e " ${AMARILLO}💡 ${FRASES[$INDICE]}${RESET}"
echo ""
echo -e " ${GRIS}═════════════════════════════════════════════════════════════════${RESET}"
echo ""
