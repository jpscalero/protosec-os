#!/usr/bin/env python3
# =============================================================================
# generate-wallpaper.py — Generador de fondo de pantalla de ProtoSec OS 1.0
#
# Crea un wallpaper 1920x1080 con:
#   - Degradado vertical de #1A1A2E (arriba) a #0D0D0D (abajo)
#   - Efecto "lluvia de caracteres" estilo Matrix en verde #00FF41
#   - Logo "ProtoSec" centrado en grande
#   - Eslogan "Hack. Analyze. Deploy." en naranja #FF6B35
#
# Dependencia: python3-pil (Pillow)
# Salida: /usr/share/backgrounds/protosec-wallpaper.png
# =============================================================================

import random
import os
import sys

try:
    from PIL import Image, ImageDraw, ImageFont, ImageFilter
except ImportError:
    print("ERROR: Se requiere Pillow. Instala con: apt install python3-pil", file=sys.stderr)
    sys.exit(1)

# ---- Dimensiones ----
ANCHO = 1920
ALTO = 1080

# ---- Colores ----
COLOR_ARRIBA = (26, 26, 46)       # #1A1A2E — azul noche
COLOR_ABAJO = (13, 13, 13)        # #0D0D0D — negro profundo
COLOR_VERDE = (0, 255, 65)        # #00FF41 — verde hacker
COLOR_NARANJA = (255, 107, 53)    # #FF6B35 — naranja acento
COLOR_SOMBRA = (0, 0, 0)          # Sombra para el texto

# ---- Caracteres para el efecto Matrix ----
# Dígitos + letras mayúsculas + una selección de katakana
DIGITOS = "0123456789"
LETRAS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
KATAKANA = "アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン"
CARACTERES = DIGITOS + LETRAS + KATAKANA

# ---- Ruta de salida ----
RUTA_SALIDA = "/usr/share/backgrounds/protosec-wallpaper.png"


def buscar_fuente(nombres, tamano):
    """Busca una fuente TrueType por nombre en las rutas comunes del sistema."""
    rutas_base = [
        "/usr/share/fonts/truetype/",
        "/usr/share/fonts/",
        "/usr/local/share/fonts/",
    ]
    for nombre in nombres:
        for base in rutas_base:
            for raiz, dirs, archivos in os.walk(base):
                for archivo in archivos:
                    if archivo.lower() == nombre.lower():
                        try:
                            return ImageFont.truetype(os.path.join(raiz, archivo), tamano)
                        except (IOError, OSError):
                            continue
    # Último recurso: fuente por defecto de Pillow
    print("AVISO: No se encontraron fuentes TrueType, usando fuente por defecto.", file=sys.stderr)
    return ImageFont.load_default()


def interpolar_color(c1, c2, factor):
    """Interpola linealmente entre dos colores RGB."""
    return tuple(int(c1[i] + (c2[i] - c1[i]) * factor) for i in range(3))


def crear_degradado(imagen, color_arriba, color_abajo):
    """Dibuja un degradado vertical en la imagen."""
    draw = ImageDraw.Draw(imagen)
    for y in range(ALTO):
        factor = y / ALTO
        color = interpolar_color(color_arriba, color_abajo, factor)
        draw.line([(0, y), (ANCHO, y)], fill=color)


def dibujar_lluvia_matrix(imagen):
    """Dibuja columnas de caracteres estilo Matrix con opacidad variable."""
    # Crear capa transparente para los caracteres
    capa_matrix = Image.new("RGBA", (ANCHO, ALTO), (0, 0, 0, 0))
    draw = ImageDraw.Draw(capa_matrix)

    # Fuente pequeña para los caracteres de la lluvia
    fuente_matrix = buscar_fuente(
        ["DejaVuSansMono.ttf", "FiraCode-Regular.ttf", "LiberationMono-Regular.ttf"],
        14
    )

    tam_celda_x = 18  # Separación horizontal entre columnas
    tam_celda_y = 18  # Separación vertical entre caracteres

    num_columnas = ANCHO // tam_celda_x
    num_filas = ALTO // tam_celda_y

    for col in range(num_columnas):
        # No todas las columnas tienen caracteres (efecto disperso)
        if random.random() > 0.6:
            continue

        # Longitud aleatoria de la columna
        longitud = random.randint(num_filas // 4, num_filas)
        inicio_fila = random.randint(0, num_filas - 1)

        for i in range(longitud):
            fila = (inicio_fila + i) % num_filas
            x = col * tam_celda_x
            y = fila * tam_celda_y

            # Opacidad: más transparente arriba, más opaco abajo
            # También los caracteres más recientes (al final) son más brillantes
            factor_posicion = y / ALTO
            factor_recencia = i / longitud
            opacidad = int(20 + 60 * factor_posicion * factor_recencia)
            opacidad = min(opacidad, 120)  # Limitar para que no tape el logo

            caracter = random.choice(CARACTERES)
            color_con_alfa = (COLOR_VERDE[0], COLOR_VERDE[1], COLOR_VERDE[2], opacidad)
            draw.text((x, y), caracter, font=fuente_matrix, fill=color_con_alfa)

    # Componer la capa Matrix sobre la imagen base
    imagen_rgba = imagen.convert("RGBA")
    imagen_rgba = Image.alpha_composite(imagen_rgba, capa_matrix)
    return imagen_rgba.convert("RGB")


def dibujar_texto_principal(imagen):
    """Dibuja el logo 'ProtoSec' y el eslogan centrados."""
    draw = ImageDraw.Draw(imagen)

    # ---- Fuente grande para "ProtoSec" ----
    fuente_logo = buscar_fuente(
        ["FiraCode-Bold.ttf", "FiraCode-SemiBold.ttf", "DejaVuSans-Bold.ttf"],
        100
    )

    # ---- Fuente mediana para el eslogan ----
    fuente_eslogan = buscar_fuente(
        ["FiraCode-Regular.ttf", "DejaVuSans.ttf", "NotoSans-Regular.ttf"],
        30
    )

    texto_logo = "ProtoSec"
    texto_eslogan = "Hack. Analyze. Deploy."

    # Calcular posiciones centradas para el logo
    bbox_logo = draw.textbbox((0, 0), texto_logo, font=fuente_logo)
    ancho_logo = bbox_logo[2] - bbox_logo[0]
    alto_logo = bbox_logo[3] - bbox_logo[1]
    x_logo = (ANCHO - ancho_logo) // 2
    y_logo = (ALTO - alto_logo) // 2 - 40

    # Sombra del logo (desplazada 3px)
    draw.text((x_logo + 3, y_logo + 3), texto_logo, font=fuente_logo, fill=COLOR_SOMBRA)
    # Logo principal
    draw.text((x_logo, y_logo), texto_logo, font=fuente_logo, fill=COLOR_VERDE)

    # Calcular posiciones centradas para el eslogan
    bbox_eslogan = draw.textbbox((0, 0), texto_eslogan, font=fuente_eslogan)
    ancho_eslogan = bbox_eslogan[2] - bbox_eslogan[0]
    x_eslogan = (ANCHO - ancho_eslogan) // 2
    y_eslogan = y_logo + alto_logo + 20

    # Sombra del eslogan
    draw.text((x_eslogan + 2, y_eslogan + 2), texto_eslogan, font=fuente_eslogan, fill=COLOR_SOMBRA)
    # Eslogan principal
    draw.text((x_eslogan, y_eslogan), texto_eslogan, font=fuente_eslogan, fill=COLOR_NARANJA)


def main():
    """Función principal: genera y guarda el wallpaper."""
    print("╔══════════════════════════════════════════════╗")
    print("║  Generador de Wallpaper — ProtoSec OS 1.0   ║")
    print("╚══════════════════════════════════════════════╝")
    print()

    # Crear imagen base
    print("[1/4] Creando imagen base con degradado...")
    imagen = Image.new("RGB", (ANCHO, ALTO))
    crear_degradado(imagen, COLOR_ARRIBA, COLOR_ABAJO)

    # Dibujar lluvia Matrix
    print("[2/4] Dibujando efecto lluvia Matrix...")
    imagen = dibujar_lluvia_matrix(imagen)

    # Dibujar texto principal
    print("[3/4] Añadiendo logo y eslogan...")
    dibujar_texto_principal(imagen)

    # Crear directorio de salida si no existe
    directorio_salida = os.path.dirname(RUTA_SALIDA)
    os.makedirs(directorio_salida, exist_ok=True)

    # Guardar imagen
    print(f"[4/4] Guardando wallpaper en: {RUTA_SALIDA}")
    imagen.save(RUTA_SALIDA, "PNG", optimize=True)

    tamano_mb = os.path.getsize(RUTA_SALIDA) / (1024 * 1024)
    print()
    print(f"✓ Wallpaper generado correctamente ({tamano_mb:.2f} MB)")
    print(f"  Resolución: {ANCHO}x{ALTO}")
    print(f"  Ruta: {RUTA_SALIDA}")


if __name__ == "__main__":
    main()
