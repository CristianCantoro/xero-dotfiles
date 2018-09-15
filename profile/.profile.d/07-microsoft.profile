#!/usr/bin/env bash

##############################################################################
# MICROSOFT AZURE
#
# azure-cli completion

# Microsoft Azure completion
alias azure-activate='nvm use stable && . <(azure --completion)'

if command -v azure &>/dev/null; then
  # shellcheck disable=SC1090
  source <(azure --completion)
fi
