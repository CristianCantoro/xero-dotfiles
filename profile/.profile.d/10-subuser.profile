#!/usr/bin/env bash

##############################################################################
# SUBUSER
#
# add subuser to PATH
if [ -d "$HOME/.subuser" ]; then
  export PATH="$PATH:$HOME/.subuser/bin"
fi
