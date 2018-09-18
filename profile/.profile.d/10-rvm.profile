#!/usr/bin/env bash

##############################################################################
# RVM
# See https://rvm.io
#
# Add RVM to PATH for scripting
export PATH="$HOME/.rvm/bin:$PATH"

# Load RVM into a shell session *as a function*
# shellcheck disable=SC1090
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# fix rvm-prompt issue
# rvm-prompt i v g &>/dev/null
