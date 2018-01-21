##############################################################################
# Unlimited history in zsh
# https://unix.stackexchange.com/questions/273861
##############################################################################
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

# Uncomment the following line if you want to change the command execution
# timestamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="yyyy-mm-dd hh:MM:SS "
# with this setting you need this alias (by default history is aliased
# to 'fc -l 1').
# alias history="fc -il 1"

# However, if you also want seconds, the solution above doesn't work as you
# would expect.
# See also:
# How do you display seconds in time?
# https://github.com/robbyrussell/oh-my-zsh/issues/6109
HIST_FORMAT="'%Y-%m-%d %T:'$(echo -e '\t')"
alias history="fc -t "$HIST_FORMAT" -il 1"

# Treat the '!' character specially during expansion.
setopt BANG_HIST

# Write the history file in the ":start:elapsed;command" format.
setopt EXTENDED_HISTORY

# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY

# Share history between all sessions.
setopt SHARE_HISTORY

# Expire duplicate entries first when trimming history.
# setopt HIST_EXPIRE_DUPS_FIRST

# Don't record an entry that was just recorded again.
setopt HIST_IGNORE_DUPS

# Delete old recorded entry if new entry is a duplicate.
# setopt HIST_IGNORE_ALL_DUPS

# Do not display a line previously found.
setopt HIST_FIND_NO_DUPS

# Don't record an entry starting with a space.
setopt HIST_IGNORE_SPACE

# Don't write duplicate entries in the history file.
setopt HIST_SAVE_NO_DUPS

# Remove superfluous blanks before recording entry.
setopt HIST_REDUCE_BLANKS

# Don't execute immediately upon history expansion.
setopt HIST_VERIFY

# Beep when accessing nonexistent history.
setopt HIST_BEEP
