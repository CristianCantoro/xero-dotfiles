#!/usr/bin/env bash

##############################################################################
# LINUXBREW
#
# See https://linuxbrew.sh
if [ -d "$HOME/.linuxbrew" ]; then
  export PATH="$HOME/.linuxbrew/sbin:$HOME/.linuxbrew/bin:$PATH"
  export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
  export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
  export XDG_DATA_DIRS="$HOME/.linuxbrew/share:$XDG_DATA_DIRS"
fi
