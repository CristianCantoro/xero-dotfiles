#!/usr/bin/env bash

##############################################################################
# CARGO
#
# add spark env variables
if [ -d "$HOME/.cargo/bin" ]; then
  export CARGO_BIN="$HOME/.cargo/bin"
  export PATH="$PATH:$CARGO_BIN"
fi
