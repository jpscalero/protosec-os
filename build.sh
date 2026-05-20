#!/bin/bash
# =====================================================================
# ProtoSec OS 1.0 — Script Principal de Construcción
# =====================================================================
# Este script orquesta todo el proceso de construcción de la ISO:
#   1. Verifica privilegios de root
#   2. Instala dependencias si faltan
#   3. Limpia construcciones anteriores
#   4. Configura live-build
#   5. Construye la ISO
#   6. Renombra, calcula hash y muestra resumen
#
# Uso: sudo ./build.sh
# =====================================================================

set -e

# --- Colores para la terminal ---
VERDE='\033[0;32m'
ROJO='\033[0;31m'
AMARILLO='\033[1;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

# --- Directorio del proyecto ---
DIR_PROYECTO="$(cd "$(dirname "${0}")" && pwd)"
ARCHIVO_LOG="${DIR_PROYECTO}/build.log"
NOMBRE_ISO="ProtoSec-1.0-amd64.iso"

# --- Función para registrar mensajes con marca de tiempo ---
registrar() {
    local mensaje
    mensaje="[$(date '+%Y-%m-%d %H:%M:%S')] $1"
    echo -e "${mensaje}" | tee -a "${ARCHIVO_LOG}"
}

# --- Función para mostrar errores y salir ---
error_salir() {
    registrar "${ROJO}[ERROR] $1${RESET}"
    registrar "${ROJO}╔══════════════════════════════════════════════════╗${RESET}"
    registrar "${ROJO}║   ¡LA CONSTRUCCIÓN HA FALLADO!                  ║${RESET}"
    registrar "${ROJO}║   Revisa el archivo build.log para más detalles ║${RESET}"
    registrar "${ROJO}╚══════════════════════════════════════════════════╝${RESET}"
    exit 1
}

# --- Capturar errores ---
trap 'error_salir "Error inesperado en la línea ${LINENO}"' ERR

# =====================================================================
# 1. BANNER ASCII
# =====================================================================
mostrar_banner() {
    echo -e "${VERDE}"
    cat << 'BANNER'
    ╔═══════════════════════════════════════════════════════════════╗
    ║                                                               ║
    ║   ██████╗ ██████╗  ██████╗ ████████╗ ██████╗ ███████╗███████╗ ║
    ║   ██╔══██╗██╔══██╗██╔═══██╗╚══██╔══╝██╔═══██╗██╔════╝██╔════╝║
    ║   ██████╔╝██████╔╝██║   ██║   ██║   ██║   ██║███████╗█████╗  ║
    ║   ██╔═══╝ ██╔══██╗██║   ██║   ██║   ██║   ██║╚════██║██╔══╝  ║
    ║   ██║     ██║  ██║╚██████╔╝   ██║   ╚██████╔╝███████║███████╗║
    ║   ╚═╝     ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚══════╝╚══════╝║
    ║                                                               ║
    ║           ProtoSec OS 1.0 — "Hack. Analyze. Deploy."         ║
    ║           Basado en Debian 12 Bookworm (amd64)                ║
    ║                                                               ║
    ╚═══════════════════════════════════════════════════════════════╝
BANNER
    echo -e "${RESET}"
}

# =====================================================================
# 2. VERIFICAR PRIVILEGIOS DE ROOT
# =====================================================================
verificar_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo -e "${ROJO}[ERROR] Este script debe ejecutarse como root (sudo).${RESET}"
        echo -e "${AMARILLO}Uso: sudo ./build.sh${RESET}"
        exit 1
    fi
    registrar "${VERDE}[OK] Ejecutando como root.${RESET}"
}

# =====================================================================
# 3. VERIFICAR E INSTALAR DEPENDENCIAS
# =====================================================================
instalar_dependencias() {
    registrar "${CYAN}[INFO] Verificando dependencias necesarias...${RESET}"

    # Lista de paquetes requeridos para la construcción
    local paquetes_requeridos=(
        live-build
        debootstrap
        squashfs-tools
        xorriso
        isolinux
        syslinux-efi
        grub-efi-amd64-bin
        mtools
        grub-pc-bin
        syslinux-common
    )

    local paquetes_faltantes=()

    # Comprobar cada paquete
    for paquete in "${paquetes_requeridos[@]}"; do
        if ! dpkg -l "${paquete}" 2>/dev/null | grep -q "^ii"; then
            paquetes_faltantes+=("${paquete}")
            registrar "${AMARILLO}[FALTA] ${paquete} no está instalado.${RESET}"
        else
            registrar "${VERDE}[OK] ${paquete} ya instalado.${RESET}"
        fi
    done

    # Instalar paquetes faltantes si los hay
    if [ ${#paquetes_faltantes[@]} -gt 0 ]; then
        registrar "${CYAN}[INFO] Instalando paquetes faltantes: ${paquetes_faltantes[*]}${RESET}"
        apt-get update -qq || error_salir "No se pudo actualizar la lista de paquetes."
        apt-get install -y "${paquetes_faltantes[@]}" || error_salir "No se pudieron instalar las dependencias."
        registrar "${VERDE}[OK] Todas las dependencias instaladas correctamente.${RESET}"
    else
        registrar "${VERDE}[OK] Todas las dependencias ya están presentes.${RESET}"
    fi
}

# =====================================================================
# 4. LIMPIAR CONSTRUCCIONES ANTERIORES
# =====================================================================
limpiar_anterior() {
    registrar "${CYAN}[INFO] Limpiando construcciones anteriores...${RESET}"
    cd "${DIR_PROYECTO}"

    # Eliminar ISO anterior si existe
    if [ -f "${NOMBRE_ISO}" ]; then
        rm -f "${NOMBRE_ISO}"
        registrar "${VERDE}[OK] ISO anterior eliminada.${RESET}"
    fi

    # Eliminar hash anterior si existe
    if [ -f "${NOMBRE_ISO}.sha256" ]; then
        rm -f "${NOMBRE_ISO}.sha256"
    fi

    # Ejecutar limpieza profunda de live-build
    lb clean --purge 2>&1 | tee -a "${ARCHIVO_LOG}" || true
    registrar "${VERDE}[OK] Limpieza completada.${RESET}"
}

# =====================================================================
# 5. CONFIGURAR LIVE-BUILD
# =====================================================================
configurar_livebuild() {
    registrar "${CYAN}[INFO] Ejecutando configuración de live-build (lb config)...${RESET}"
    cd "${DIR_PROYECTO}"
    lb config 2>&1 | tee -a "${ARCHIVO_LOG}" || error_salir "Falló la configuración de live-build (lb config)."
    registrar "${VERDE}[OK] Configuración completada exitosamente.${RESET}"
}

# =====================================================================
# 6. CONSTRUIR LA ISO
# =====================================================================
construir_iso() {
    registrar "${CYAN}[INFO] Iniciando construcción de la ISO... (esto puede tardar bastante)${RESET}"
    registrar "${AMARILLO}[AVISO] Tiempo estimado: 30-90 minutos dependiendo del hardware e internet.${RESET}"
    cd "${DIR_PROYECTO}"

    local inicio
    inicio=$(date +%s)
    lb build 2>&1 | tee -a "${ARCHIVO_LOG}" || error_salir "Falló la construcción de la ISO (lb build)."
    local fin
    fin=$(date +%s)
    local duracion=$((fin - inicio))
    local minutos=$((duracion / 60))
    local segundos=$((duracion % 60))

    registrar "${VERDE}[OK] Construcción completada en ${minutos}m ${segundos}s.${RESET}"
}

# =====================================================================
# 7. RENOMBRAR ISO Y GENERAR HASH
# =====================================================================
finalizar_iso() {
    registrar "${CYAN}[INFO] Finalizando ISO...${RESET}"
    cd "${DIR_PROYECTO}"

    # Buscar la ISO generada por live-build
    local iso_generada=""
    for candidata in live-image-amd64.hybrid.iso live-image-amd64.iso; do
        if [ -f "${candidata}" ]; then
            iso_generada="${candidata}"
            break
        fi
    done

    if [ -z "${iso_generada}" ]; then
        error_salir "No se encontró la ISO generada. Revisa los logs."
    fi

    # Renombrar la ISO
    mv "${iso_generada}" "${NOMBRE_ISO}"
    registrar "${VERDE}[OK] ISO renombrada a ${NOMBRE_ISO}${RESET}"

    # Calcular hash SHA256
    registrar "${CYAN}[INFO] Calculando hash SHA256...${RESET}"
    sha256sum "${NOMBRE_ISO}" > "${NOMBRE_ISO}.sha256"
    local hash
    hash=$(cat "${NOMBRE_ISO}.sha256")
    registrar "${VERDE}[OK] SHA256: ${hash}${RESET}"

    # Obtener tamaño de la ISO
    local tamano
    tamano=$(du -h "${NOMBRE_ISO}" | cut -f1)
    registrar "${VERDE}[OK] Tamaño de la ISO: ${tamano}${RESET}"
}

# =====================================================================
# 8. RESUMEN FINAL
# =====================================================================
mostrar_resumen() {
    local tamano
    tamano=$(du -h "${NOMBRE_ISO}" 2>/dev/null | cut -f1 || echo "N/A")
    local hash
    hash=$(cut -d' ' -f1 "${NOMBRE_ISO}.sha256" 2>/dev/null || echo "N/A")

    echo ""
    echo -e "${VERDE}"
    cat << RESUMEN
    ╔══════════════════════════════════════════════════════════════╗
    ║          ¡CONSTRUCCIÓN COMPLETADA CON ÉXITO!                ║
    ╠══════════════════════════════════════════════════════════════╣
    ║                                                              ║
    ║  Archivo ISO : ${NOMBRE_ISO}
    ║  Tamaño      : ${tamano}
    ║  SHA256      : ${hash}
    ║  Log         : ${ARCHIVO_LOG}
    ║                                                              ║
    ║  Para grabar en USB:                                         ║
    ║    sudo dd if=${NOMBRE_ISO} of=/dev/sdX bs=4M status=progress ║
    ║                                                              ║
    ║  ProtoSec OS 1.0 — "Hack. Analyze. Deploy."                 ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝
RESUMEN
    echo -e "${RESET}"
}

# =====================================================================
# EJECUCIÓN PRINCIPAL
# =====================================================================
main() {
    # Inicializar archivo de log
    echo "" > "${ARCHIVO_LOG}"
    registrar "=========================================="
    registrar "ProtoSec OS 1.0 — Inicio de construcción"
    registrar "=========================================="

    mostrar_banner
    verificar_root
    instalar_dependencias
    limpiar_anterior
    configurar_livebuild
    construir_iso
    finalizar_iso
    mostrar_resumen

    registrar "=========================================="
    registrar "ProtoSec OS 1.0 — Construcción finalizada"
    registrar "=========================================="
}

# Ejecutar
main "$@"
