# Load the default .profile, should be shell safe
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

# Mass move
autoload -U zmv

# pushd options
setopt autopushd pushdminus pushdsilent pushdtohome

# activate extended globbing
setopt extended_glob

if [[ -z $TMUX ]]; then
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
fi

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

# gcloud autocompletion
if command -v gcloud >/dev/null; then
  if [ -d '/usr/share/google-cloud-sdk' ]; then
    source /usr/share/google-cloud-sdk/completion.zsh.inc
  fi
fi

# zsh autosuggetion style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=100'

# zsh history database (zsh-histdb)
# see:
#   - https://github.com/larkery/zsh-histdb
if [ -f "$HOME/.oh-my-zsh/custom/plugins/zsh-histdb/sqlite-history.zsh" ]; then
  source "$HOME/.oh-my-zsh/custom/plugins/zsh-histdb/sqlite-history.zsh"
  autoload -Uz add-zsh-hook

  source "$HOME/.oh-my-zsh/custom/plugins/zsh-histdb/histdb-interactive.zsh"
  bindkey '^F' _histdb-isearch
fi
