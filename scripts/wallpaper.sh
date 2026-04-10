#!/usr/bin/env bash
set -euo pipefail

echo "🖼️  Iniciando script de wallpaper..."

WALLPAPERS_DIR="$HOME/Pictures/Wallpapers"

# ======================
# ESPERAR Y ASEGURAR QUE EL DAEMON ESTÉ CORRIENDO
# ======================
echo "⏳ Esperando a que swww-daemon inicie..."

for i in {1..15}; do
    if /usr/local/bin/swww query &>/dev/null; then
        echo "✅ swww-daemon está corriendo correctamente"
        break
    fi
    
    if [ $i -eq 8 ]; then
        echo "⚠️  Daemon no detectado, intentando iniciarlo manualmente..."
        /usr/local/bin/swww-daemon &
        sleep 1
    fi
    
    sleep 0.6
done

# Si después de todo sigue sin funcionar, forzar
if ! /usr/local/bin/swww query &>/dev/null; then
    echo "❌ No se pudo iniciar el daemon automáticamente. Inténtalo manualmente con: swww-daemon"
    exit 1
fi

# ======================
# SELECCIONAR Y APLICAR WALLPAPER
# ======================
if [ ! -d "$WALLPAPERS_DIR" ] || [ -z "$(ls -A "$WALLPAPERS_DIR" 2>/dev/null)" ]; then
    echo "❌ No hay imágenes en $WALLPAPERS_DIR"
    exit 1
fi

WALL=$(find "$WALLPAPERS_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) | shuf -n 1)

echo "✅ Aplicando wallpaper: $(basename "$WALL")"

# Aplicar con transición suave
/usr/local/bin/swww img "$WALL" \
    --transition-type grow \
    --transition-pos 0.5,0.5 \
    --transition-step 90 \
    --transition-fps 60 \
    --transition-duration 2

# Actualizar tema con pywal
wal -i "$WALL" --saturate 0.8 -q

echo "🎨 Wallpaper y colores aplicados correctamente"
