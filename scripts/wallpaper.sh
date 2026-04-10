#!/usr/bin/env bash
set -euo pipefail

# =========================
# VARIABLES (ROBUSTAS)
# =========================
# Detecta automáticamente la carpeta wallpapers/ del repo
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
DIR="$DOTFILES_DIR/wallpapers"

echo "🖼️  Buscando wallpapers en: $DIR"

# =========================
# VERIFICAR QUE EXISTAN IMÁGENES
# =========================
if [ ! -d "$DIR" ] || [ -z "$(ls -A "$DIR" 2>/dev/null)" ]; then
    echo "❌ Error: No se encontró la carpeta wallpapers/ o está vacía"
    exit 1
fi

# Elegir una imagen al azar (png, jpg, jpeg)
WALL=$(find "$DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) | shuf -n 1)

if [ -z "$WALL" ]; then
    echo "❌ Error: No se encontraron imágenes válidas en $DIR"
    exit 1
fi

echo "✅ Aplicando wallpaper: $(basename "$WALL")"

# =========================
# INICIAR SWWW (si no está corriendo)
# =========================
swww query &>/dev/null || swww-daemon --format xrgb &

# =========================
# APLICAR WALLPAPER
# =========================
swww img "$WALL" \
    --transition-type grow \
    --transition-pos 0.5,0.5 \
    --transition-step 90 \
    --transition-fps 60

# =========================
# ACTUALIZAR COLORES (pywal)
# =========================
wal -i "$WALL" --saturate 0.8

echo "🎨 Wallpaper y colores aplicados correctamente"
