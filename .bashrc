#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export PATH=$PATH:/home/dhanu/.spicetify

alias ll='lsd -a --group-dirs=first'

export MOZ_ENABLE_WAYLAND=1
export LIBVA_DRIVER_NAME=nvidia
export MOZ_DISABLE_RDD_SANDBOX=1
export NVD_BACKEND=direct
export QT_CURSOR_SIZE=24
. "$HOME/.cargo/env"
