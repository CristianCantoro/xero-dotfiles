#!/usr/bin/env bash

# Enhanced bash strict mode:
#   https://balist.es/blog/2017/03/21/
#     enhancing-the-unofficial-bash-strict-mode/
#
# shellcheck disable=SC2128
SOURCED=false && [ "$0" = "$BASH_SOURCE" ] || SOURCED=true

if ! $SOURCED; then
  set -euo pipefail
  IFS=$'\n\t'
fi

# we check that we are in an SSH connection, if SSH_AUTH_SOCK is not set we
# set it sourcing a dedicated config script
set -- "$SSH_CONNECTION"
if [[ ! -z $PS1 ]]; then
  if [[ ! -z $SSH_TTY ]]; then
    if [[ -z $TMUX ]]; then
      if [[ "$1" != "$3" ]]; then
        if ! test "$SSH_AUTH_SOCK" ; then
          echo "Set SSH_AUTH_SOCK"
          tmux_home="$HOME/.tmux"
          tmux source-file "$tmux_home/tmux_ssh_auth_sock.conf"
        fi
      fi
    fi
  fi
fi

exit 0