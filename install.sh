#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Aplicando dotfiles..."

# =========================
# VARIABLES (ROBUSTAS)
# =========================
# Detecta automáticamente dónde está el repo, sin importar el nombre ni la ubicación
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$DOTFILES_DIR/config"

echo "📍 Dotfiles encontrados en: $DOTFILES_DIR"

# =========================
# BACKUP
# =========================
backup() {
    if [ -e "$1" ] && [ ! -L "$1" ]; then
        echo "📦 Backup de $1 → $1.bak"
        mv "$1" "$1.bak"
    fi
}

# =========================
# SYMLINK
# =========================
link_config() {
    local src="$1"
    local dest="$2"

    backup "$dest"

    echo "🔗 $dest → $src"
    ln -sf "$src" "$dest"
}

# =========================
# CREAR ~/.config
# =========================
mkdir -p "$HOME/.config"

# =========================
# CONFIGS (solo las que realmente tienes)
# =========================
link_config "$CONFIG_DIR/hypr"  "$HOME/.config/hypr"
link_config "$CONFIG_DIR/kitty" "$HOME/.config/kitty"
link_config "$CONFIG_DIR/nvim"  "$HOME/.config/nvim"

# swww (opcional - solo si la carpeta existe)
if [ -d "$CONFIG_DIR/swww" ]; then
    link_config "$CONFIG_DIR/swww" "$HOME/.config/swww"
fi
echo "💤 Instalando y activando plugins de Neovim..."

# 1. Asegurar que la configuración se mueva a su lugar antes de borrar Miarch
mkdir -p ~/.config/nvim
cp -r ~/Miarch/dotfiles/nvim/* ~/.config/nvim/

# 2. Instalar el gestor de plugins (Lazy.nvim) si no está
if [ ! -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]; then
  git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable "$HOME/.local/share/nvim/lazy/lazy.nvim"
fi

# 3. COMANDO CLAVE: Forzar la instalación de plugins sin abrir la interfaz
# Esto hace que nvim instale todo y se cierre solo al terminar
nvim --headless "+Lazy! sync" +qa
# =========================
# ZSH
# =========================
if [ -f "$DOTFILES_DIR/home/.zshrc" ]; then
    backup "$HOME/.zshrc"
    echo "🔗 ~/.zshrc → $DOTFILES_DIR/home/.zshrc"
    ln -sf "$DOTFILES_DIR/home/.zshrc" "$HOME/.zshrc"
fi
# =========================
# SCRIPTS
# =========================
if [ -d "$DOTFILES_DIR/scripts" ]; then
    echo "⚙️ Aplicando permisos a scripts..."
    chmod +x "$DOTFILES_DIR/scripts/"* 2>/dev/null || true
fi

# =========================
# WALLPAPER
# =========================
if [ -f "$DOTFILES_DIR/scripts/wallpaper.sh" ]; then
    echo "🖼️ Aplicando wallpaper..."
    bash "$DOTFILES_DIR/scripts/wallpaper.sh" || echo "⚠️ Error aplicando wallpaper"
fi

# =========================
# FINAL
# =========================
echo "✅ Dotfiles aplicados correctamente"
# =========================
# MUDANZA Y LIMPIEZA FINAL
# =========================
echo "🚚 Organizando archivos en sus destinos definitivos..."

# 1. Crear estructura estándar y carpeta de Wallpapers
xdg-user-dirs-update
mkdir -p ~/Pictures/Wallpapers
mkdir -p ~/.local/bin

# 2. Mover Wallpapers y el Script
cp -r ~/Miarch/wallpapers/* ~/Pictures/Wallpapers/
cp ~/Miarch/scripts/wallpaper.sh ~/.local/bin/wallpaper.sh
chmod +x ~/.local/bin/wallpaper.sh

# 3. ELIMINAR EL REPOSITORIO (Limpieza de obra)
echo "🧹 Borrando carpeta de instalación Miarch..."
rm -rf ~/Miarch

echo "✅ Sistema autónomo y limpio."
