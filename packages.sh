#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Iniciando instalación de paquetes para Miarch (Hyprland)..."

# =========================
# ACTUALIZAR SISTEMA
# =========================
echo "📦 Actualizando sistema..."
sudo pacman -Syu --noconfirm

# =========================
# INSTALAR PAQUETES OFICIALES (pacman)
# =========================
echo "📥 Instalando paquetes oficiales..."

sudo pacman -S --noconfirm --needed \
    hyprland \
    waybar \
    rofi-wayland \
    dunst \
    kitty \
    zsh \
    neovim \
    git \
    curl \
    base-devel \
    python-pywal \
    grim \
    slurp \
    swww \
    xdg-desktop-portal-hyprland \
    mesa \
    ttf-jetbrains-mono-nerd \
    ttf-font-awesome \
    network-manager-applet \
    brightnessctl \
    pavucontrol \
    playerctl

# =========================
# INSTALAR AUR HELPER (yay) si no existe
# =========================
if ! command -v yay &> /dev/null; then
    echo "🔧 Instalando yay (AUR helper)..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
fi

# =========================
# INSTALAR PAQUETES AUR
# =========================
echo "📥 Instalando paquetes AUR..."
yay -S --noconfirm --needed \
    google-chrome \
    # Aquí puedes agregar más paquetes AUR en el futuro

# =========================
# INSTALACIÓN MANUAL DE SWWW (por si acaso)
# =========================
if ! command -v swww &> /dev/null; then
    echo "🖼️ Instalando swww desde fuente..."
    
    # 1. Limpieza total del entorno de compilación
    rm -rf /tmp/swww
    
    # 2. Clonar el repositorio oficial
    git clone https://github.com/LGFae/swww.git /tmp/swww
    cd /tmp/swww

    # 3. Instalación profesional con Cargo
    # --path .  -> Instala el proyecto actual
    # --locked  -> Usa las versiones exactas de librerías del proyecto
    cargo install --path . --locked

    # 4. Mover binarios a una ruta del sistema (Cargo suele dejarlos en ~/.cargo/bin)
    # Esto asegura que cualquier usuario o script los encuentre
    sudo cp ~/.cargo/bin/swww /usr/local/bin/
    sudo cp ~/.cargo/bin/swww-daemon /usr/local/bin/

    # 5. Limpieza post-instalación
    cd -
    rm -rf /tmp/swww
    echo "✅ swww instalado correctamente."
fi
# =========================
# FINAL
# =========================
echo "✅ ¡Instalación de paquetes completada!"
echo "   Ahora ejecuta: bash install.sh"

