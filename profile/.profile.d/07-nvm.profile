#!/usr/bin/env bash

##############################################################################
# NVM
#
# Add NVM
# See https://github.com/creationix/nvm
NVM_DIR="$(realpath "$HOME/.nvm")"
export NVM_DIR
# shellcheck disable=SC1090
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
