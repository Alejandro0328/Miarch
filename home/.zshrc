# --- [1] COLORES DINÁMICOS (PYWAL) ---
# Importamos la paleta antes de que cargue el prompt para que use los nuevos colores
[[ -f ~/.cache/wal/sequences ]] && cat ~/.cache/wal/sequences
[[ -f ~/.cache/wal/colors-shell.sh ]] && source ~/.cache/wal/colors-shell.sh

# --- [2] TU CONFIGURACIÓN ORIGINAL DE OH MY ZSH ---
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

# --- [3] TU CONFIGURACIÓN DE PROMPT (RECUPERADA) ---

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

# Aquí está tu identidad: Icono Arch, nombre (alejandro/%n), iconos de carpeta y flechas ()
PROMPT='%F{cyan}󰣇 %f %F{magenta}%n%f $(dir_icon) %F{red}%~%f%${vcs_info_msg_0_} %F{yellow}$(parse_git_branch)%f %(?.%B%F{green}.%F{red})%f%b '

# --- [4] TUS ALIAS ---
alias l="eza -lh --icons=auto"
alias ls="eza -ha --icons=auto --sort=name --group-directories-first"
alias n="nvim"
alias wall="~/.config/hypr/scripts/wallpaper.sh"

# --- [5] INICIO AUTOMÁTICO ---
if command -v fastfetch > /dev/null; then
    fastfetch
fi

# Fix de lenguaje e iconos para tu HP EliteBook
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
