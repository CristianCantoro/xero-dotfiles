# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

## debug
#echo "sourcing $HOME/.profile"
#if [ -z ${PROFILE_LOADED+x} ]; then
#  # echo "sourcing $HOME/.profile"
#  export PROFILE_LOADED=true
#else
#  # echo "already sourced $HOME/.profile"
#  return
#fi

# set PATH so it includes user's private bin directories
# if it exists
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

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

# if SSH_AUTH_SOCK is unset then the agent is not working for sure
if [ -z "${SSH_AUTH_SOCK+x}" ]; then
  # activate ssh-agent on login
  # https://stackoverflow.com/a/18915067/2377454

  SSH_ENV="$HOME/.ssh/environment"

  function start_ssh_agent {
    echo -n 'Initialising new SSH agent...'

    # start agent and save environment in SSH_ENV
    ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"

    # source SSH_ENV
    # shellcheck disable=SC1090
    source "${SSH_ENV}" > /dev/null

    ssh-add

    echo ' succeeded'
  }

  # Source SSH settings, if applicable
  if [ -f "${SSH_ENV}" ]; then
    chmod 600 "${SSH_ENV}"

    # shellcheck disable=SC1090
    source "${SSH_ENV}" > /dev/null
  fi

  # if ssh-agent is not running and SSH_AGENT_PID not set
  if ! pgrep -f ssh-agent > /dev/null && [ ! -z "${SSH_AGENT_PID}" ]; then
    start_ssh_agent
  fi

fi
