# =============================================================================
# Miarch - Configuración Zsh (Clean & Minimal)
# =============================================================================

# --- [1] COLORES DINÁMICOS CON PYWAL ---
[[ -f ~/.cache/wal/sequences ]] && cat ~/.cache/wal/sequences
[[ -f ~/.cache/wal/colors-shell.sh ]] && source ~/.cache/wal/colors-shell.sh

# --- [2] OH MY ZSH ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="afowler"
ENABLE_CORRECTION="true"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search
)

source $ZSH/oh-my-zsh.sh

# --- [3] PROMPT PERSONALIZADO ---
function dir_icon {
    if [[ "$PWD" == "$HOME" ]]; then
        echo "%B%F{black}%f%b"
    else
        echo "%B%F{cyan}%f%b"
    fi
}

function parse_git_branch {
    local branch
    branch=$(git symbolic-ref --short HEAD 2> /dev/null)
    if [ -n "$branch" ]; then
        echo " [$branch]"
    fi
}

PROMPT='%F{cyan}󰣇 %f %F{magenta}%n%f $(dir_icon) %F{red}%~%f%${vcs_info_msg_0_} %F{yellow}$(parse_git_branch)%f %(?.%B%F{green}.%F{red})%f%b '

# --- [4] ALIAS ÚTILES ---
alias l="eza -lh --icons=auto --group-directories-first"
alias ls="eza -ha --icons=auto --sort=name --group-directories-first"
alias ll="eza -lah --icons=auto --git"
alias lt="eza --tree --level=2 --icons"
alias n="nvim"
alias v="code"                    # ← Visual Studio Code
alias wall="~/.local/bin/wallpaper.sh"   # ← Corregido (nueva ubicación)

# --- [5] INICIO AUTOMÁTICO ---
if command -v fastfetch > /dev/null; then
    fastfetch
fi

# --- [6] VARIABLES DE ENTORNO ---
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Asegurar que ~/.local/bin esté en el PATH
export PATH="$HOME/.local/bin:$PATH"
