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
