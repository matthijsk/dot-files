export VISUAL=vim
export EDITOR="$VISUAL"
export PATH=$PATH:$(go env GOPATH)/bin

alias ll='ls -lh'
alias grep='grep --color=auto'

alias g='git'
alias vd='vimdiff'
alias gvd='gvimdiff'
alias ec='emacsclient -n'
alias ecn='emacsclient -nw'
