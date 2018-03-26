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

# set tab size to 2
export SHELL_TAB_SIZE=2
tabs "$SHELL_TAB_SIZE"

# set my GPG key
export GPGKEY='0xF4B4A1414B2F9555'

# python virtualenv
if which pyenv &>/dev/null; then
  echo 'foo'
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
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Linuxbrew (linuxbrew.sh)
export PATH="$HOME/.linuxbrew/bin:$PATH"

