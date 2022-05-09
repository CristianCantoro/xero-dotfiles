# Setup fzf
# ---------
if [[ ! "$PATH" == */home/cconsonni/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/cconsonni/.fzf/bin"
fi

# Auto-completion
# ---------------
# [[ $- == *i* ]] && source "/home/cconsonni/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/cconsonni/.fzf/shell/key-bindings.bash"
