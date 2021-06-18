#!/usr/bin/env bash

##############################################################################
# PYTHON
#
# python virtualenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# startup virtualenv-burrito
# See:
# https://github.com/brainsik/virtualenv-burrito
# if [ -f "$HOME/.venvburrito/startup.sh" ]; then
#   . "$HOME/.venvburrito/startup.sh"
# elif [ -f "/usr/local/bin/virtualenvwrapper.sh" ]; then
#   # Python virtualenvwrapper problem running the initialization hooks
#   # https://askubuntu.com/a/995130/71067
#   export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
#   export WORKON_HOME="$HOME/.virtualenvs"
#   mkdir -p "$WORKON_HOME"
#
#   . /usr/local/bin/virtualenvwrapper.sh
# fi
