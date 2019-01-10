#!/usr/bin/env bash

##############################################################################
# TMUX
#
# tmux over ssh
# See:
#   https://balist.es/blog/2015/02/09/firing-tmux-when-logging-in-via-ssh/
# this is disabled for root, if you are logging in via ssh as root, you have a
# problem
if [ -f "$HOME/.scripts/tmux.sh" ]; then
  if [[ $UID -ne 0 ]]; then
    # shellcheck disable=SC1090
    source "$HOME/.scripts/tmux.sh"
    # if TMUX is defined then set TERM to screen-256color
    if [ -n "$TMUX" ]; then
      export TERM='tmux-256color'
    fi
  fi
fi
