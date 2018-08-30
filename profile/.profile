# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin directories
# if it exists
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

# hostname
HOSTNAME="$(hostname)"
export HOSTNAME

# set tab size to 2
export SHELL_TAB_SIZE=2
tabs "$SHELL_TAB_SIZE"

# set my GPG key
export GPGKEY='0xF4B4A1414B2F9555'

# set lang
export LANG='en_US.UTF-8'

# python virtualenv
if command -v pyenv &>/dev/null; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# startup virtualenv-burrito
# See:
# https://github.com/brainsik/virtualenv-burrito
if [ -f "$HOME/.venvburrito/startup.sh" ]; then
    # shellcheck source=/dev/null
    . "$HOME/.venvburrito/startup.sh"
fi

# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

# Load RVM into a shell session *as a function*
# shellcheck disable=SC1090
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Linuxbrew (linuxbrew.sh)
export PATH="$HOME/.linuxbrew/bin:$PATH"

# ssh-add -l returns the error code 2 if it cannot connect to the agent:
#   $ ssh-add -l
#   Error connecting to agent: No such file or directory
#   $ echo $?
#   2
function ssh_agent_cant_connect {
  ssh-add -l &>/dev/null
  if [ "$?" == 2 ]; then
    return 0
  else
    return 1
  fi
}

# if SSH_AUTH_SOCK is unset then the agent is not working for sure
if [ -z "${SSH_AUTH_SOCK+x}" ]; then

  if ssh_agent_cant_connect; then
    # activate ssh-agent on login
    # https://stackoverflow.com/a/18915067/2377454

    SSH_ENV="$HOME/.ssh/environment"

    function start_ssh_agent {
      echo 'Initialising new SSH agent...'

      # start agent and save environment in SSH_ENV
      (umask 066; ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}")

      # source SSH_ENV
      # shellcheck disable=SC1090
      source "${SSH_ENV}" > /dev/null

      ssh-add
    }

    # Source SSH settings, if applicable
    if test -r "${SSH_ENV}"; then
      chmod 600 "${SSH_ENV}"

      # shellcheck disable=SC1090
      source "${SSH_ENV}" > /dev/null
    fi

    # if ssh-agent is not running and SSH_AGENT_PID not set
    if ! pgrep -f ssh-agent > /dev/null && [ ! -z "${SSH_AGENT_PID}" ]; then
      start_ssh_agent
    fi

  fi

fi

# tmux over ssh
# See:
#   https://balist.es/blog/2015/02/09/firing-tmux-when-logging-in-via-ssh/
# this is disabled for root, if you are logging in via ssh as root, you have a
# problem
if [[ $UID -ne 0 ]]; then
  # shellcheck disable=SC1090
  source "$HOME/.scripts/tmux.sh"
  # if TMUX is defined then set TERM to screen-256color
  if [[ ! -z "$TMUX" ]]; then
    export TERM='tmux-256color'
  fi
fi

# add restic env vars
# shellcheck disable=SC1090
[ -f "$HOME/.restic/environment" ] && \
  source "$HOME/.restic/environment"

# add bup env vars
# shellcheck disable=SC1090
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
  eval "$(perl -I"$HOME/perl5/lib/perl5" -Mlocal::lib)"
fi

# Add NVM
# See https://github.com/creationix/nvm
NVM_DIR="$(realpath "$HOME/.nvm")"
export NVM_DIR
# shellcheck disable=SC1090
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Go
if [ -d "$HOME/go" ]; then
  export GOPATH="$HOME/go"
  export PATH="$HOME/go/bin:$PATH"
fi

# azure-cli completion
if command -v azure &>/dev/null; then
  # shellcheck disable=SC1090
  source <(azure --completion)
fi

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
if [ -d "$HOME/.subuser" ]; then
  export PATH=$HOME/.subuser/bin:$PATH
fi

# add spark env variables
if [ -d '/opt/spark/spark' ]; then
  export SPARK_HOME='/opt/spark/spark'
  export PATH="$SPARK_HOME/bin:$PATH"
fi
