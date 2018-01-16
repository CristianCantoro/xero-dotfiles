#!/usr/bin/env bash

# bash strict mode
# See:
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

verify_tmux_version () {
    tmux_home="$HOME/.tmux"
    tmux_version="$(tmux -V | cut -c 6-)"

    if [[ $(echo "$tmux_version >= 2.1" | bc) -eq 1 ]] ; then
        echo "tmux version >= 2.1"
        tmux source-file "$tmux_home/tmux_2.1_up.conf"
        exit
    elif [[ $(echo "$tmux_version >= 1.9" | bc) -eq 1 ]] ; then
        echo "tmux version >= 1.9"
        tmux source-file "$tmux_home/tmux_1.9_to_2.1.conf"
        exit
    else
        echo "tmux version < 1.9"
        tmux source-file "$tmux_home/tmux_1.9_down.conf"
        exit
    fi
}

verify_tmux_version