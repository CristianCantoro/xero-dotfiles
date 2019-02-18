#!/usr/bin/env bash

##############################################################################
# Go
if [ -d "$HOME/go" ]; then
  export GOPATH="$HOME/go"
  export PATH="$HOME/go/bin:$PATH"
fi

# https://github.com/golang/go/wiki/Modules#how-to-use-modules
export GO111MODULE=auto
