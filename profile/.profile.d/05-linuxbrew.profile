#!/usr/bin/env bash

##############################################################################
# LINUXBREW
#
# See https://linuxbrew.sh
BREW_INSTALLED=false
if [ -d '/home/linuxbrew/.linuxbrew' ]; then
  BREW_INSTALLED=true
  BREW_PREFIX='/home/linuxbrew/.linuxbrew'
elif [ -d "$HOME/.linuxbrew" ]; then
  BREW_INSTALLED=true
  BREW_PREFIX="$HOME/.linuxbrew"
fi

if $BREW_INSTALLED; then
  export PATH="$BREW_PREFIX/sbin:$BREW_PREFIX/bin:$PATH"
  export MANPATH="$BREW_PREFIX/share/man:$MANPATH"
  export INFOPATH="$BREW_PREFIX/share/info:$INFOPATH"
  export XDG_DATA_DIRS="$BREW_PREFIX/share:$XDG_DATA_DIRS"

  export BREW_DISABLED=false
fi
