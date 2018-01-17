# Load the default .profile, should be shell safe
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

case $TERM in
  rxvt|*term|gnome-*)
  precmd() { print -Pn "\e]0;%m:::$(basename $PWD)\a" }
  preexec () { print -Pn "\e]0;$1\a" }
  ;;
esac

# Mass move
autoload -U zmv

# tmux over ssh
# See:
#   https://balist.es/blog/2015/02/09/
#     firing-tmux-when-logging-in-via-ssh/
source "$HOME/.scripts/tmux.sh"

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
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Go
# export GOPATH="$HOME/go"
# export PATH="$HOME/go/bin:$PATH"

# Perl modules
# shellcheck disable=SC2086
# eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"

# azure-cli completion
# source <(azure --completion)

# reload theme
( [ -f "$ZSH/themes/$ZSH_THEME.zsh-theme" ] && \
    source "$ZSH/themes/$ZSH_THEME.zsh-theme" ) && \
  ( [ -f "$ZSH/custom/themes/$ZSH_THEME.zsh-theme" ] && \
    source "$ZSH/custom/themes/$ZSH_THEME.zsh-theme")

# Add Haskell package manager (cargo) to path
# export PATH="$HOME/.cargo/bin:$PATH"

# de-duplicate PATH
# shellcheck disable=SC2153
if [[ "$FPATH" ==  *".oh-my-zsh/custom/functions"* ]]; then
    autoload dedup_PATH
    dedup_PATH
fi

# Run SSH with GPG support
# see:
# https://github.com/dainnilsson/scripts/blob/master/base-install/gpg.sh
# export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"

# Load RVM into a shell session *as a function*
# Add RVM to PATH for scripting
# See https://rvm.io
# export PATH="$HOME/.rvm/bin:$PATH"
