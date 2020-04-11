#!/usr/bin/env bash

# filter ls using globbing
alias 'lsglob'='ls -lahd'

##############################################################################
# LS
#
# Parsing ls is bad (https://mywiki.wooledge.org/ParsingLs) and the two
# following function may be - and probably indeed are - the dumbest functions
# ever written. However, I find it more natural to use `ls | grep` instead of
# using globbing properly.
#
# If you are reading this and you are thinking about using these function in a
# script, don't! These functions have been written with the knowledge that
# **they are going to fail**, furthermore, they are very slow. These functions
# are written with the idea of being used in a shell by a user.

# basically an alias to `ls -lh FILE | grep -E FILTER`
function lsgrep() (

  function __lsgrep__short_usage() {
    (>&2 echo 'Usage: lsgrep [options] FILTER [FILE]...' )
  }

  function __lsgrep__usage() {
    __lsgrep__short_usage
    # shellcheck disable=SC2016
    (>&2 echo \
'
List FILE with `ls -lAh` and pipe them through `grep -E FILTER`.
Results are colorized with ls. This command is equivalent to:
    ```
    ls -lh FILE | grep -E FILTER
    ```

Argumeacnts:
  FILTER           Pattern to pass to `grep -E` to filter results.

Options:
  FILE             Files to list [default: .].
  -A               Do not list hidden files.
  -r               Reverse order (pass option -r to ls).
  -t               Sort by modification time (pass option -t to ls).
  -h               Show this help and exit.

Example:
  lsgrep alias')
  }

  function __lsgrep__cleanup() {
    unset -f __lsgrep__short_usage
    unset -f __lsgrep__usage

    unset -f __lsgrep__cleanup
  }
  trap "__lsgrep__cleanup" EXIT

  local deflag_A='-A'
  local rflag=''
  local tflag=''
  local show_help=false
  declare -a FILE

  set -- "$@"
  while getopts ":Ahrt" opt; do
    case "$opt" in
      A)
        deflag_A=''
        ;;
      h)
        show_help=true
        ;;
      r)
        rflag='-r'
        ;;
      t)
        tflag='-t'
        ;;
      \?)
        ( echo "Error. Invalid option: -$OPTARG" >&2 )
        __lsgrep__short_usage
        return 1
        ;;
    esac
  done

  if $show_help; then
    __lsgrep__usage
    return 0
  fi

  # Shell Script: is mixing getopts with positional parameters possible?
  # http//stackoverflow.com/q/11742996/2377454
  numopt="$#"
  if (( numopt-OPTIND < 0 )); then
    (>&2 echo "Error. Parameter FILTER is required.")
    __lsgrep__short_usage
    return 1
  fi

  declare -a tmpfilter
  tmpfilter=( "${@:$OPTIND:1}" )
  FILTER="${tmpfilter[*]}"
  if (( numopt-OPTIND > 0 )); then
    FILE=( "${@:$OPTIND+1}" )
  else
    FILE=( '.' )
  fi

  /bin/ls ${deflag_A:-} ${rflag:-} ${tflag:-} -lh --color=always \
      "${FILE[@]}" | /bin/grep -E --color=never "${FILTER[@]}"

  return 0
)

# filter filenames with grep and pass them to ls
function lsfilter() (

  function __lsfilter__short_usage() {
    (>&2 echo 'Usage: lsfilter [options] PATTERN [FILE]...' )
  }

  function __lsfilter__usage() {
    __lsfilter__short_usage
    # shellcheck disable=SC2016
    (>&2 echo \
'
List FILE like `ls -lAh` and filter their name with PATTERN. Results are
colorized with ls.

Argumeacnts:
  PATTERN           Pattern to filter results.

Options:
  FILE              Files to list [default: .].
  -A                Do not list hidden files.
  -r                Reverse order (pass option -r to ls).
  -t                Sort by modification time (pass option -t to ls).
  -h                Show this help and exit.

Example:
  lsfilter alias')
  }

  local scratch
  scratch=$(mktemp -d -t lsfilter.XXXXXXXXXX)
  function __lsfilter__cleanup() {
    unset -f __lsfilter__short_usage
    unset -f __lsfilter__usage

    rm -rf "$scratch"
    unset -f __lsfilter__cleanup
  }
  trap "__lsfilter__cleanup" EXIT

  local deflag_A='-A'
  local rflag=''
  local tflag=''
  local show_help=false
  declare -a FILE

  set -- "$@"
  while getopts ":Ahrt" opt; do
    case "$opt" in
      A)
        deflag_A=''
        ;;
      h)
        show_help=true
        ;;
      r)
        rflag='-r'
        ;;
      t)
        tflag='-t'
        ;;
      \?)
        ( echo "Error. Invalid option: -$OPTARG" >&2 )
        __lsfilter__short_usage
        return 1
        ;;
    esac
  done

  if $show_help; then
    __lsfilter__usage
    return 0
  fi

  # Shell Script: is mixing getopts with positional parameters possible?
  # http//stackoverflow.com/q/11742996/2377454
  numopt="$#"
  if (( numopt-OPTIND < 0 )); then
    (>&2 echo "Error. Parameter PATTERN is required.")
    __lsfilter__short_usage
    return 1
  fi

  declare -a tmppattern
  tmppattern=( "${@:$OPTIND:1}" )
  PATTERN="${tmppattern[*]}"
  if (( numopt-OPTIND > 0 )); then
    FILE=( "${@:$OPTIND+1}" )
  else
    FILE=( '.' )
  fi

  local afile; local afoundfile; local afoundfilename;
  local afilteredfile
  for afile in "${FILE[@]}"; do
    touch "$scratch/output-ls.txt"
    while IFS=$'\n' read -r afoundfile; do
      afoundfilename="$(basename "$afoundfile")"
      if echo "$afoundfilename" | \
            /bin/grep -E "${PATTERN[@]}" >/dev/null; then
        if [ "$afile" == '.' ]; then
          afilteredfile="${afoundfilename}"
        else
          afilteredfile="${afile}/${afoundfilename}"
        fi

        if [ -d "$afilteredfile" ]; then
          /bin/ls -dlh --color=always "$afilteredfile" >> "$scratch/output-ls.txt"
        else
          /bin/ls -lh --color=always "$afilteredfile" >> "$scratch/output-ls.txt"
        fi
      fi
    done < <( /bin/ls -1 ${deflag_A:-} ${rflag:-} ${tflag:-} "$afile" )
  done

  column -o $'\t' -t "$scratch/output-ls.txt" | \
      cut -f 1-8 --output-delimiter ' ' | \
      column -t -R 5,7 > "$scratch/part1.txt"

  column -o $'\t' -t "$scratch/output-ls.txt" | \
      cut -f 9- | column -o ' ' | \
      sed -r 's/\s+->\s+/ -> /g' > "$scratch/part2.txt"

  paste "$scratch/part1.txt" "$scratch/part2.txt" | column -t -s $'\t'

  return 0
)
