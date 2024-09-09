bindkey -e

alias ecn='emacsclient -n'

export GPG_TTY=$(tty)
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

autoload -Uz compinit && compinit
