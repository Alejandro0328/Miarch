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
    playerctl \
    xdg-user-dirs \
    fastfetch \
    dolphin \
    eza

# =========================
# INSTALAR OH MY ZSH + PLUGINS
# =========================
echo "🐚 Configurando Zsh y Oh My Zsh..."

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "🪄 Instalando Oh My Zsh (modo desatendido)..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    # Cambiar shell por defecto a zsh
    sudo chsh -s "$(which zsh)" "$USER" || echo "⚠️  No se pudo cambiar el shell predeterminado"
fi

# Instalar plugins de Zsh
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
plugins=("zsh-autosuggestions" "zsh-syntax-highlighting" "zsh-history-substring-search")

for plugin in "${plugins[@]}"; do
    if [ ! -d "$ZSH_CUSTOM/plugins/$plugin" ]; then
        echo "📥 Instalando plugin: $plugin"
        git clone --depth=1 "https://github.com/zsh-users/$plugin" "$ZSH_CUSTOM/plugins/$plugin" || true
    else
        echo "✅ Plugin $plugin ya está instalado"
    fi
done

# =========================
# INSTALAR AUR HELPER (yay)
# =========================
if ! command -v yay &> /dev/null; then
    echo "🔧 Instalando yay (AUR helper)..."
    rm -rf /tmp/yay
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
fi

# =========================
# INSTALAR PAQUETES AUR
# =========================
echo "📥 Instalando paquetes desde AUR..."
yay -S --noconfirm --needed \
    google-chrome \
    visual-studio-code-bin

# =========================
# INSTALACIÓN MANUAL DE SWWW (compilación limpia)
# =========================
echo "🔧 Instalando swww desde fuente..."
rm -rf /tmp/swww
git clone https://github.com/LGFae/swww.git /tmp/swww
cd /tmp/swww

# Compilar y instalar
cargo build --release

sudo install -Dm755 target/release/swww /usr/local/bin/swww
sudo install -Dm755 target/release/swww-daemon /usr/local/bin/swww-daemon

cd -
rm -rf /tmp/swww

# =========================
# FINAL
# =========================
echo "✅ ¡Instalación de paquetes completada correctamente!"
echo ""
echo "   Ahora puedes ejecutar la instalación completa con:"
echo "   bash install.sh"
echo ""
echo "   O en una sola línea:"
echo "   git clone https://github.com/Alejandro0328/Miarch.git ~/Miarch && cd ~/Miarch && bash packages.sh && bash install.sh"

