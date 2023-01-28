export ZSH="$HOME/.oh_my_zsh"

ZSH_THEME="cloud"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(z git zsh-syntax-highlighting zsh-autocomplete zsh-autosuggestions  vscode docker python pip history sudo dirhistory )

# include Z, yo
. ~/z.sh

# User configuration
export DEFAULT_USER="$(whoami)"

alias upd='sudo apt update'
alias upg='sudo apt upgrade'
alias untar='tar -zxvf' # Unpack .tar file

# McFly - fly through your shell history
# https://github.com/cantino/mcfly
eval "$(mcfly init zsh)"
