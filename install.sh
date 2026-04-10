#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Iniciando instalación de dotfiles Miarch..."

# =========================
# DETECTAR UBICACIÓN DEL REPO
# =========================
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$DOTFILES_DIR/config"

echo "📍 Dotfiles encontrados en: $DOTFILES_DIR"

# =========================
# FUNCIONES AUXILIARES
# =========================
backup() {
    if [ -e "$1" ] && [ ! -L "$1" ]; then
        echo "📦 Creando backup: $1 → $1.bak"
        mv "$1" "$1.bak"
    fi
}

copy_config() {
    local src="$1"
    local dest="$2"

    if [ -d "$src" ]; then
        backup "$dest"
        echo "📋 Copiando configuración: $src → $dest"
        mkdir -p "$(dirname "$dest")"
        cp -r "$src" "$dest"
    else
        echo "⚠️  Advertencia: $src no existe, saltando..."
    fi
}

# =========================
# PREPARACIÓN DEL SISTEMA
# =========================
echo "📁 Preparando directorios del usuario..."
xdg-user-dirs-update          # Crea Pictures, Documents, etc. de forma estándar
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/Pictures/Wallpapers"   # Subcarpeta específica para tus wallpapers

# =========================
# COPIAR CONFIGURACIONES
# =========================
echo "🔧 Aplicando configuraciones..."

copy_config "$CONFIG_DIR/hypr"  "$HOME/.config/hypr"
copy_config "$CONFIG_DIR/kitty" "$HOME/.config/kitty"
copy_config "$CONFIG_DIR/nvim"  "$HOME/.config/nvim"

# swww (opcional)
if [ -d "$CONFIG_DIR/swww" ]; then
    copy_config "$CONFIG_DIR/swww" "$HOME/.config/swww"
fi

# =========================
# COPIAR ZSH
# =========================
if [ -f "$DOTFILES_DIR/home/.zshrc" ]; then
    backup "$HOME/.zshrc"
    echo "🔗 Copiando ~/.zshrc"
    cp "$DOTFILES_DIR/home/.zshrc" "$HOME/.zshrc"
fi

# =========================
# NEOVIM - Instalar plugins con Lazy.nvim
# =========================
echo "💤 Instalando plugins de Neovim..."
if [ -d "$HOME/.config/nvim" ]; then
    # Instalar Lazy.nvim si no existe
    if [ ! -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]; then
        echo "📥 Clonando Lazy.nvim..."
        git clone --filter=blob:none https://github.com/folke/lazy.nvim.git \
            --branch=stable "$HOME/.local/share/nvim/lazy/lazy.nvim"
    fi

    # Instalar plugins en modo headless
    echo "🔄 Sincronizando plugins de Neovim..."
    nvim --headless "+Lazy! sync" +qa || echo "⚠️  Neovim terminó con errores (posiblemente normal en primer arranque)"
else
    echo "⚠️  Carpeta de nvim no encontrada, saltando instalación de plugins"
fi

# =========================
# COPIAR WALLPAPERS
# =========================
if [ -d "$DOTFILES_DIR/wallpapers" ]; then
    echo "🖼️  Copiando wallpapers a ~/Pictures/Wallpapers/"
    cp -r "$DOTFILES_DIR/wallpapers/"* "$HOME/Pictures/Wallpapers/" 2>/dev/null || true
fi

# =========================
# COPIAR SCRIPT DE WALLPAPER
# =========================
if [ -f "$DOTFILES_DIR/scripts/wallpaper.sh" ]; then
    echo "⚙️  Instalando script de wallpaper en ~/.local/bin/"
    cp "$DOTFILES_DIR/scripts/wallpaper.sh" "$HOME/.local/bin/wallpaper.sh"
    chmod +x "$HOME/.local/bin/wallpaper.sh"
fi

# =========================
# PERMISOS DE SCRIPTS
# =========================
if [ -d "$DOTFILES_DIR/scripts" ]; then
    chmod +x "$DOTFILES_DIR/scripts/"* 2>/dev/null || true
fi

# =========================
# APLICAR WALLPAPER
# =========================
echo "🖼️  Aplicando wallpaper inicial..."
if [ -f "$HOME/.local/bin/wallpaper.sh" ]; then
    "$HOME/.local/bin/wallpaper.sh" || echo "⚠️  Error al aplicar wallpaper"
else
    echo "⚠️  wallpaper.sh no encontrado"
fi

# =========================
# LIMPIEZA FINAL - BORRAR REPO
# =========================
echo "🧹 Limpiando archivos de instalación..."
rm -rf "$DOTFILES_DIR"

echo "✅ ¡Instalación completada con éxito!"
echo "   El sistema ahora es autónomo."
echo "   Reinicia tu sesión para aplicar todos los cambios."
