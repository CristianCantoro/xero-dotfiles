#!/usr/bin/env bash

# strip color from shell output
# See:
# https://unix.stackexchange.com/questions/111899/
#   how-to-strip-color-codes-out-of-stdout-and-pipe-to-file-and-stdout/
#   111936#111936
alias stripcolors='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"'

# maintain colors through pipes
# alias 'forcecolors_grep'='grep --color=always'
# alias 'forcecolors_ls'='ls --color=always'
# alias 'forcecolors'='unbuffer'
function forcecolors() {
  if [[ $# -lt 1 ]] ; then
    (>&2 echo 'Usage: forcecolors <command>'
         echo 'at least one argument required')
    exit 1
  fi

  case "$*" in
    ls* )
    shift 1; ls --color=always "$@"
    ;;
  grep* )
    shift 1; grep --color=always "$@"
    ;;
  * )
    unbuffer "$@"
    ;;
  esac

  return 0
}

# suppress color in grep
alias 'grepnoc'='grep --color=never'
