# Load the default .profile, should be shell safe
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

case $TERM in
  rxvt|*term|gnome-*)

    # fix issue with %[A-z], zsh interpret these symbols as
    # command sequences with a special meaning:
    # See:
    # https://github.com/robbyrussell/oh-my-zsh/issues/521
    # https://bugs.launchpad.net/ubuntu/+source/zsh/+bug/435336
    precmd() { print -Pn $'\e]0;%m:::$(basename $PWD)\a' }
    preexec () { print -Pn $'\e]0;${~1:gs/%/%%}\a' }
    ;;
esac

# Getting command-not-found working under zsh
# https://askubuntu.com/a/324761/71067
if [[ -s '/etc/zsh_command_not_found' ]]; then
  source '/etc/zsh_command_not_found'
fi

# reload theme
( [ -f "$ZSH/themes/$ZSH_THEME.zsh-theme" ] && \
    source "$ZSH/themes/$ZSH_THEME.zsh-theme" ) && \
  ( [ -f "$ZSH/custom/themes/$ZSH_THEME.zsh-theme" ] && \
    source "$ZSH/custom/themes/$ZSH_THEME.zsh-theme")

# Mass move
autoload -U zmv

# activate extended globbing
setopt extended_glob

# autoload function in $ZSH_CUSTOM/functions and autocompletions
if [ -d "$ZSH_CUSTOM/functions" ]; then
  for funcfile in "$ZSH_CUSTOM"/functions/^_*(.); do
    funcname=$(basename "$funcfile")
    autoload "$funcname"
  done

  # if there are autocompletion files, force reload to activate them
  set -- "$ZSH_CUSTOM"/functions/_*
  if [ "$#" -gt 0 ]; then
    source $ZSH/oh-my-zsh.sh
  fi
fi

# de-duplicate PATH
if [ -f "$ZSH_CUSTOM/functions/dedup_PATH" ]; then
  dedup_PATH
fi

# tmux over ssh
# See:
#   https://balist.es/blog/2015/02/09/firing-tmux-when-logging-in-via-ssh/
# this is disabled for root, if you are logging in via ssh as root, you have a
# problem
if [[ $UID -ne 0 ]]; then
  source "$HOME/.scripts/tmux.sh"
  # if TMUX is defined then set TERM to screen-256color
  if [[ ! -z "$TMUX" ]]; then
    export TERM='tmux-256color'
  fi
fi

# add restic env vars
[ -f "$HOME/.restic/environment" ] && \
  source "$HOME/.restic/environment"

# add bup env vars
[ -f "$HOME/.bup/environment" ] && \
  source "$HOME/.bup/environment"

# Load RVM into a shell session *as a function*
  # shellcheck disable=SC1090
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Linuxbrew
# See https://linuxbrew.sh
export PATH="$HOME/.linuxbrew/sbin:$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
export XDG_DATA_DIRS="$HOME/.linuxbrew/share:$XDG_DATA_DIRS"

# Perl modules
# shellcheck disable=SC2086
PERL='/usr/bin/perl'
export PERL
if [ -d "$HOME/perl5" ]; then
  export PERL5LIB="$HOME/perl5/"
  eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
fi

# Add NVM
# See https://github.com/creationix/nvm
export NVM_DIR="$(realpath $HOME/.nvm)"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Go
# export GOPATH="$HOME/go"
# export PATH="$HOME/go/bin:$PATH"

# azure-cli completion
# source <(azure --completion)

# Add Haskell package manager (cargo) to path
# export PATH="$HOME/.cargo/bin:$PATH"

# Run SSH with GPG support
# see:
# https://github.com/dainnilsson/scripts/blob/master/base-install/gpg.sh
# export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"

# Load RVM into a shell session *as a function*
# Add RVM to PATH for scripting
# See https://rvm.io
export PATH="$HOME/.rvm/bin:$PATH"
# fix rvm-prompt issue
# rvm-prompt i v g &>/dev/null

# add subuser to PATH
[ -d "$HOME/.subuser" ] && \
  export PATH=$HOME/.subuser/bin:$PATH

# add spark env variables
export SPARK_HOME='/opt/spark/spark'
export PATH="$SPARK_HOME/bin:$PATH"
