# Aliases for a desktop system
if [ "$XDG_SESSION_TYPE" == "x11" ]; then

  # Alias to lock and blank screen
  alias lock='gnome-screensaver-command -l'
  alias blank='gnome-screensaver-command -a'
  alias blank-lock='blank && lock'

  # Alias for Zotero
  if [ -d '/opt/Zotero' ]; then
    alias zotero='/opt/Zotero/Zotero_linux-x86_64/zotero'
  fi

  # Telegram
  if [ -d '/opt/Telegram' ]; then
    alias telegram='/opt/Telegram/Telegram &>/dev/null &'
    alias telegram-updater='/opt/Telegram/Updater'
  fi

  # Tor Browser
  if [ -d '/opt/tor' ]; then
    alias tor-browser='/opt/tor/tor-browser_en-US/start-tor-browser'
  fi

  # Eclipse
  # shellcheck disable=SC2139
  # /home/<user>/eclipse/<eclipse-version>/eclipse
  if [ -d "$HOME/eclipse" ]; then
    alias eclipse="$(find "$HOME/eclipse" -type f -executable -name 'eclipse')"
  fi

fi
