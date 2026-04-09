#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Inicio de instalación"
# Verificar sistema
if ! grep -q "Arch" /etc/os-release; then
    echo "❌ Este script es solo para Arch Linux"
    exit 1
fi
echo "🔄 Actualizando sistema..."
sudo pacman -Syu --noconfirm
echo "📦 Instalando paquetes base..."

sudo pacman -S --noconfirm \
    neovim \
    zsh \
    kitty \
    waybar \
    rofi \
    dunst \
    git \
    base-devel \
    grim \
    slurp
# Instalar yay si no existe
if ! command -v yay &>/dev/null; then
    echo "📦 Instalando yay..."

    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd ~
fi
echo "📦 Instalando paquetes AUR..."

yay -S --noconfirm \
    google-chrome \
    python-pywal
# Instalar swww
if ! command -v swww &>/dev/null; then
    echo "🖼️ Instalando swww..."

    git clone https://aur.archlinux.org/swww.git /tmp/swww
    cd /tmp/swww
    makepkg -si --noconfirm
    cd ~
fi
echo "✅ Instalación completa"

