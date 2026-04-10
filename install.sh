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
