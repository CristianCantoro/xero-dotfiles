# Aliases for a desktop system

# Sublime Text
# shellcheck disable=SC2139
alias sublimetext="$HOME/.scripts/sublimetext.zsh"

# Alias to lock and blank screen
alias lock='gnome-screensaver-command -l'
alias blank='gnome-screensaver-command -a'
alias blank-lock='blank && lock'

# Alias for Zotero
alias zotero='gnome-terminal --tab -e
                 "/opt/Zotero/Zotero_linux-x86_64/run-zotero.sh"'

# Telegram
alias telegram='/opt/Telegram/Telegram &>/dev/null &'
alias telegram-updater='/opt/Telegram/Updater'

# Tor Browser
alias tor-browser='/opt/tor/tor-browser_en-US/start-tor-browser'

# Eclipse
# shellcheck disable=SC2139
alias eclipse="$HOME/eclipse/java-neon/eclipse/eclipse"

# yED graph editor
# shellcheck disable=SC2139
alias yed="$HOME/.scripts/yed.sh"