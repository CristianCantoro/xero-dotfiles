# Aliases

# Directory history
setopt autopushd pushdminus pushdsilent pushdtohome
alias dirsh='dirs -v'

# Mass move
autoload -U zmv
alias mmv='noglob zmv -W'

# Alias for apt-get update/apt-get upgrade
if command -v apt &>/dev/null; then
  alias aptupdate='sudo apt update && sudo apt --assume-yes upgrade'
fi

# Interactive version of move and copy
alias mv='mv -i'
alias cp='cp -i'

# Alias for ps
alias psgrep='ps ax | grep'

# Alias for directory size listing
alias dirsize='du -h -s'

# get my IP using http://canihazip.com/s
# http://n3mesisfixx.blogspot.it/2013/02/
#    what-is-my-public-ip-from-command-line.html
if command -v curl &>/dev/null; then
  alias canihazip='curl -w "\n" https://canihazip.com/s'
elif command -v wget &>/dev/null; then
  alias canihazip='wget https://canihazip.com/s -O - -q; echo'
fi
if command -v canihazip &>/dev/null; then
  alias getip='canihazip'
fi

# Alias to generate random password
alias genpass="</dev/urandom tr -dc '12345!@#$%qwertQWERTasdfgASDFGzxcvbZXCVB' \
               | head -c32; echo ''"

# Microsoft Azure completion
alias azure-activate='nvm use stable && . <(azure --completion)'

# Show which port is listening on
if command -v sudo &>/dev/null && command -v netstat &>/dev/null; then
  alias whichport='sudo netstat -tulpn'
fi

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
  else
    case $* in
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
  fi
}

# suppress color in grep
alias 'grepnoc'='grep --color=never'

# ssh remove key from authorized_keys
# shellcheck disable=SC2139
alias ssh-remove="ssh-keygen -f '$HOME/.ssh/known_hosts' -R"

# Run gpg2 instead of gpg
alias gpg=gpg2

# Linuxbrew update and upgrade
if command -v brew &>/dev/null; then
  alias brewupdate='brew update && brew upgrade'
fi

# BFG Repo-Cleaner
# https://rtyley.github.io/bfg-repo-cleaner/
if command -v java &>/dev/null && [ -f '/opt/BFG_repocleaner/bfg.jar' ]; then
  alias bfg='java -jar /opt/BFG_repocleaner/bfg.jar'
fi

# Start a clean bash shell
# https://unix.stackexchange.com/q/48994/162158
alias cleanbash='env -i
                  HOME="$HOME"
                  LC_CTYPE="${LC_ALL:-${LC_CTYPE:-$LANG}}"
                  PATH="$PATH"
                  USER="$USER"
                  TERM="$TERM"
                    bash --noprofile --rcfile "$HOME/.cleanbashrc"'

# use 'bat' instead of 'cat'
# https://remysharp.com/2018/08/23/cli-improved
if command -v bat &>/dev/null; then
  alias cat='bat'
fi
