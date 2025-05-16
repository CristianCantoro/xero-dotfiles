#!/bin/bash
# Aliases

# Alias for apt-get update/apt-get upgrade
if command -v apt &>/dev/null; then
  alias aptupdate='sudo apt update && sudo apt --assume-yes upgrade'
  alias aptclean='sudo apt --assume-yes autoremove && sudo apt --assume-yes autoclean'
fi

# Interactive version of move and copy
alias mv='mv -i'
alias cp='cp -i'

# Alias for ps
alias psgrep='ps ax | grep'

# Alias for directory size listing
alias dirsize='du -h -s'

# Show only relevant mounts
function cleandf {
  df -h | \
    grep -v /snap/ | \
    grep -v tmpfs | \
    grep -v udev | \
    grep -v fuse
}

# Get size of system directories
function systemsize {
  (  LC_ALL=C
    echo "## $(date --iso=seconds)"
    echo '```bash'
    sudo du -s  \
      /sbin/ \
      /bin/  \
      /etc/  \
      /tmp/  \
      /boot/ \
      /lib/  \
      /opt/  \
      /snap/ \
      /var/  \
      /usr/  \
      /home/ \
      2>/dev/null \
        | sort -n \
        | cut -f2 \
        | tr '\n' '\0' \
        | xargs -0 -I {} sudo du -sh "{}" \
        | sort -h
    echo '```'
  )
}

# get my IP using http://canihazip.com/s
# http://n3mesisfixx.blogspot.it/2013/02/
#    what-is-my-public-ip-from-command-line.html
if command -v curl &>/dev/null; then
  alias canihazip='curl -s https://api.ipify.org'
  alias canihazip6='curl -s https://api6.ipify.org'
elif command -v wget &>/dev/null; then
  alias canihazip='wget https://api.ipify.org -O - -q; echo'
  alias canihazip6='wget https://api6.ipify.org -O - -q; echo'
fi
if command -v canihazip &>/dev/null; then
  alias getip='canihazip'
  alias getip6='canihazip6'
fi

# Alias to generate random password
alias genpass="</dev/urandom tr -dc '12345!@#$%qwertQWERTasdfgASDFGzxcvbZXCVB' \
               | head -c32; echo ''"

# Show which port is listening on
if command -v sudo &>/dev/null && command -v netstat &>/dev/null; then
  alias whichport='sudo netstat -tulpn'
fi

# ssh remove key from authorized_keys
# shellcheck disable=SC2139
alias ssh-remove="ssh-keygen -f '$HOME/.ssh/known_hosts' -R"

# Run gpg2 instead of gpg
alias gpg=gpg2

# Linuxbrew update and upgrade
if command -v brew &>/dev/null; then
  alias brewupdate='brew update && brew upgrade'
  alias brewclean='brew cleanup'
fi

# Start a clean bash shell
# https://unix.stackexchange.com/q/48994/162158
function cleanbash {
  env -i \
    HOME="$HOME" \
    LC_CTYPE="${LC_ALL:-${LC_CTYPE:-$LANG}}" \
    PATH="$PATH" \
    USER="$USER" \
    TERM="$TERM" \
      bash --noprofile --rcfile "$HOME/.cleanbashrc"

  return $?
}

# use 'bat' instead of 'cat'
# https://remysharp.com/2018/08/23/cli-improved
# if command -v bat &>/dev/null; then
#   alias cat='bat'
# fi

# sort by date
alias sort_by_date='sort -k 1,2M -k 2,3n -k 3,4n'

if command -v sar &>/dev/null; then
  alias sysstat='sar'
fi

if command -v /usr/local/bin/parallel &>/dev/null; then
  alias gnu-parallel="/usr/local/bin/parallel"
fi

if command -v spectrum_ls &>/dev/null; then
  alias color_list='spectrum_ls && spectrum_bls'
fi
