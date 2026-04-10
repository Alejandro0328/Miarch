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
    echo "🔧 Instalando swww desde fuente..."
    git clone https://github.com/LGFae/swww.git /tmp/swww
    cd /tmp/swww
    cargo install --path . --locked
    cd -
    rm -rf /tmp/swww
fi

# =========================
# FINAL
# =========================
echo "✅ ¡Instalación de paquetes completada!"
echo "   Ahora ejecuta: bash install.sh"

