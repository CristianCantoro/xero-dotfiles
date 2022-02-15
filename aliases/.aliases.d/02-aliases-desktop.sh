#!/bin/bash
# Aliases for a desktop system
if [ "$XDG_SESSION_TYPE" = "x11" ]; then

  # Alias to lock and blank screen
  alias lock='gnome-screensaver-command -l'
  alias blank='gnome-screensaver-command -a'
  alias blank-lock='blank && lock'

  # Eclipse
  # shellcheck disable=SC2139
  # /home/<user>/eclipse/<eclipse-version>/eclipse
  if [ -d "$HOME/eclipse" ]; then
    alias eclipse="$(find "$HOME/eclipse" -type f -executable -name 'eclipse')"
  fi

  if command -v subl &>/dev/null; then
    alias sublimetext='subl'
  fi

fi
