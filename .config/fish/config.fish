set -g fish_greeting ""
starship init fish | source
alias ll="lsd -a --group-dirs=first"
fzf --fish | source
