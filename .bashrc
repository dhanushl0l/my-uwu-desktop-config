#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

export PATH=$PATH:/home/dhanu/.spicetify

eval "$(starship init bash)"

alias ll='lsd -a --group-dirs=first'

export MOZ_ENABLE_WAYLAND=1
export LIBVA_DRIVER_NAME=nvidia
export MOZ_DISABLE_RDD_SANDBOX=1
export QT_CURSOR_SIZE=24
