#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Iniciando instalación de paquetes para Miarch (Hyprland)..."

# =========================
# ACTUALIZAR SISTEMA
# =========================
echo "📦 Actualizando sistema..."
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm xdg-user-dirs
# =========================
# INSTALAR PAQUETES OFICIALES (pacman)
# =========================
echo "📥 Instalando paquetes oficiales..."
# Instalación de Zsh y Oh My Zsh
if ! command -v zsh &> /dev/null; then
    echo "🐚 Instalando Zsh..."
    sudo pacman -S --noconfirm zsh
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "🪄 Instalando Oh My Zsh..."
    # Usamos el instalador desatendido para que no interrumpa el script
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    # Cambiar el shell por defecto a zsh
    sudo chsh -s $(which zsh) $USER
fi
echo "🔌 Asegurando repositorios de plugins Zsh..."
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# Lista de plugins a clonar
plugins=(
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
    "zsh-history-substring-search"
)

# Bucle para clonar cada uno si no está presente
for plugin in "${plugins[@]}"; do
    if [ ! -d "$ZSH_CUSTOM/plugins/$plugin" ]; then
        echo "📥 Clonando $plugin..."
        git clone https://github.com/zsh-users/$plugin ${ZSH_CUSTOM}/plugins/$plugin
    else
        echo "✅ $plugin ya está instalado."
    fi
done

sudo pacman -S --noconfirm --needed \
    fastfetch \
    dolphin \
    hyprland \
    waybar \
    rofi-wayland \
    dunst \
    kitty \
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

