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
# =========================
# INSTALACIÓN MANUAL DE SWWW
# =========================
# Limpiamos cualquier rastro previo
rm -rf /tmp/swww

# Clonamos usando la URL pura (sin corchetes ni paréntesis)
git clone https://github.com/LGFae/swww.git /tmp/swww

# Entramos, compilamos e instalamos
cd /tmp/swww
cargo build --release

# Movilizamos los binarios a la ruta del sistema
sudo cp target/release/swww /usr/local/bin/
sudo cp target/release/swww-daemon /usr/local/bin/

# Volvemos al directorio anterior y limpiamos
cd -
rm -rf /tmp/swww
# =========================
# FINAL
# =========================
echo "✅ ¡Instalación de paquetes completada!"
echo "   Ahora ejecuta: bash install.sh"

