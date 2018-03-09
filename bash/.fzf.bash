# Setup fzf
# ---------
if [[ ! "$PATH" == *"$HOME/.linuxbrew/opt/fzf/bin"* ]]; then
  export PATH="$PATH:$HOME/.linuxbrew/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.linuxbrew/opt/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.linuxbrew/opt/fzf/shell/key-bindings.bash"

