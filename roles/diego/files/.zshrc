export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(z git zsh-syntax-highlighting zsh-autosuggestions  vscode docker python pip history sudo dirhistory zsh-completions )

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh

# User configuration
export DEFAULT_USER="$(whoami)"

alias upd='sudo nala update'
alias upg='sudo nala upgrade'
alias untar='tar -zxvf' # Unpack .tar file

# McFly - fly through your shell history
# https://github.com/cantino/mcfly
eval "$(mcfly init zsh)"

# Configuración de Powerline fonts e iconos
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
