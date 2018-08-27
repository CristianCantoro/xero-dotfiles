# Source .bashrc
if [ -f ~/.bashrc ]; then
  # shellcheck disable=SC1090
  . ~/.bashrc
fi

# Load the default .profile
# shellcheck disable=SC1090
[[ -f "$HOME/.profile" ]] && source "$HOME/.profile"

# Set the title of a terminal window for screen
if [ -n "$STY" ]; then
  PROMPT_COMMAND='printf "\033k\033\134"'
fi
