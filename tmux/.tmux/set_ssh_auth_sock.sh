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
declare -a sshconn
IFS=' ' read -ra sshconn <<<"$SSH_CONNECTION"

if [[ ! -z "$SSH_TTY" ]]; then
  if [[ ! -z "$TMUX" ]]; then
    if [[ "${sshconn[0]}" != "${sshconn[2]}" ]]; then
      if ! test "$SSH_AUTH_SOCK" ; then
        HOSTNAME="$(hostname)"
        export HOSTNAME

        tmux_home="$HOME/.tmux"
        tmux source-file "$tmux_home/tmux_ssh_auth_sock.conf"
      fi
    fi
  fi
fi

exit 0
