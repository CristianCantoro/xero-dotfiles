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


# Compare versions in the form X.Y.Z
# Modified from:
#   https://stackoverflow.com/a/25845393/2377454
version_compare() {
  local version="$1"
  local operator="$2"
  local value="$3"

  awk -vv1="$version" -vv2="$value" 'BEGIN {
    split(v1, a, /\./); split(v2, b, /\./);
    if (a[1] == b[1]) {
      if (a[2] == b[2]) {
        exit (a[3] '"$operator"' b[3]) ? 0 : 1
      } else {
        exit (a[2] '"$operator"' b[2]) ? 0 : 1
      }
    }
    else {
      exit (a[1] '"$operator"' b[1]) ? 0 : 1
    }
  }'
}


verify_tmux_version () {
    tmux_home="$HOME/.tmux"
    tmux_version="$(tmux -V | cut -c 6-)"

    if version_compare "$tmux_version" '>=' '3'; then
        echo "tmux version >= 3"
        tmux source-file "$tmux_home/tmux_3_up.conf"
    elif version_compare "$tmux_version" '>=' '2.1'; then
        echo "tmux version >= 2.1 and < 3"
        tmux source-file "$tmux_home/tmux_2.1_to_3.conf"
    elif version_compare "$tmux_version" '>=' '1.9'; then
        echo "tmux version >= 1.9 and < 2.1"
        tmux source-file "$tmux_home/tmux_1.9_to_2.1.conf"
    else
        echo "tmux version < 1.9"
        tmux source-file "$tmux_home/tmux_1.9_down.conf"
    fi
}

verify_tmux_version

exit 0