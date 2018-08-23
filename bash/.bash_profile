## debug
#echo "sourcing $HOME/.bash_profile"
#if [ -z ${BASH_PROFILE_LOADED+x} ]; then
#  # echo "sourcing $HOME/.bash_profile"
#  export BASH_PROFILE_LOADED=true
#else
#  # echo "already sourced $HOME/.bash_profile"
#  return
#fi

# Load the default .profile
# shellcheck disable=SC1090
[[ -f "$HOME/.profile" ]] && source "$HOME/.profile"

# Set the title of a terminal window for screen
function settitle() {

  # we are in a screen session
  if [ -n "$STY" ] ; then
    echo "Setting screen titles to" "$@"
    printf "\\033k%s\\033\\" "$@"
    screen -X eval "at \\# title " "$@" "shelltitle" "$@"
  fi
}
