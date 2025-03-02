export ZSH="$HOME/.oh-my-zsh"

# https://github.com/romkatv/powerlevel10k#oh-my-zsh
ZSH_THEME="agnoster"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(z git vscode docker python pip history sudo dirhistory )

source $ZSH/oh-my-zsh.sh

# User configuration
export DEFAULT_USER="$(whoami)"

alias upd='sudo nala update'
alias upg='sudo nala upgrade'
alias untar='tar -zxvf' # Unpack .tar file

# https://aruva.medium.com/100-bash-aliases-for-supersonic-productivity-d54a796422d9

# Alias locos
alias stremio_play='docker run --rm -d -p 11470:11470 -p 12470:12470 -e NO_CORS=1 stremio/server:latest'
