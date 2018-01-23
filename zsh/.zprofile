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

# reload theme
( [ -f "$ZSH/themes/$ZSH_THEME.zsh-theme" ] && \
    source "$ZSH/themes/$ZSH_THEME.zsh-theme" ) && \
  ( [ -f "$ZSH/custom/themes/$ZSH_THEME.zsh-theme" ] && \
    source "$ZSH/custom/themes/$ZSH_THEME.zsh-theme")

# Mass move
autoload -U zmv

# de-duplicate PATH
if [ -f "$ZSH_CUSTOM/functions/dedup_PATH" ]; then
  autoload dedup_PATH
  dedup_PATH
fi

# add showip function
if [ -f "$ZSH_CUSTOM/functions/showip" ]; then
  autoload showip
  # force reload to activate autocompletion
  source $ZSH/oh-my-zsh.sh
fi

# add columncount function
if [ -f "$ZSH_CUSTOM/functions/columncount" ]; then
  autoload columncount
fi

# tmux over ssh
# See:
#   https://balist.es/blog/2015/02/09/firing-tmux-when-logging-in-via-ssh/
# this is disabled for root, if you are logging in via ssh as root, you have a
# problem
if [[ $UID -ne 0 ]]; then
  source "$HOME/.scripts/tmux.sh"
fi


# startup virtualenv-burrito
# See:
# https://github.com/brainsik/virtualenv-burrito
if [ -f "$HOME/.venvburrito/startup.sh" ]; then
    # shellcheck source=/dev/null
    . "$HOME/.venvburrito/startup.sh"
fi

# Linuxbrew
# See https://linuxbrew.sh
export PATH="$HOME/.linuxbrew/bin:$PATH"
export PATH="$HOME/.linuxbrew/sbin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
export XDG_DATA_DIRS="$HOME/.linuxbrew/share:$XDG_DATA_DIRS"

# Add NVM
# See https://github.com/creationix/nvm
export NVM_DIR="$(realpath $HOME/.nvm)"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Go
# export GOPATH="$HOME/go"
# export PATH="$HOME/go/bin:$PATH"

# Perl modules
# shellcheck disable=SC2086
# eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"

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
# export PATH="$HOME/.rvm/bin:$PATH"

# add subuser to PATH
PATH=$HOME/.subuser/bin:$PATH

