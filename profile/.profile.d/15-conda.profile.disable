#!/usr/bin/env bash
# shellcheck disable=SC1090,SC2181

##############################################################################
# PYTHON
#
# python virtualenv

if [ -d "$HOME/anaconda3/" ]; then
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$("$HOME/anaconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
      . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
      export PATH="$HOME/anaconda3/bin:$PATH"
    fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
fi

if [ -d "$HOME/miniconda3/" ]; then
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$("$HOME/miniconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
      source "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
      export PATH="$HOME/miniconda3/bin:$PATH"
    fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
fi
