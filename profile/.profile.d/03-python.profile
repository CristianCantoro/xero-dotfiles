#!/usr/bin/env bash

##############################################################################
# PYTHON
#
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
