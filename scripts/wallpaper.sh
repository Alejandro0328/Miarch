#!/bin/bash

# 1. Definir la carpeta de tus fondos
DIR="/home/alejandro/Wallpaper"

# 2. Elegir una imagen al azar
WALL=$(find "$DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)

# 3. Verificar que el daemon de swww esté corriendo
swww query || swww-daemon --format xrgb &

# 4. Aplicar la imagen con una animación genial
# Puedes cambiar 'grow' por 'outer', 'wipe', o 'wave'
# Aplicar la imagen con animación desde el centro
swww img "$WALL" --transition-type grow --transition-pos 0.5,0.5 --transition-step 90 --transition-fps 60

# 5. (Opcional) Actualizar los colores de tu terminal para que combinen
wal -i "$WALL"
