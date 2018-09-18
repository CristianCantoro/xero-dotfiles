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

# Go
if [ -d "$HOME/go" ]; then
  export GOPATH="$HOME/go"
  export PATH="$HOME/go/bin:$PATH"
fi
