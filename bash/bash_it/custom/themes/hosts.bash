#!/usr/bin/env bash
# shellcheck disable=SC2154
# You can define a color for the following 3 parts of the
# prompt:
#   - the <user> name
#   - the <at> symbol (@)
#   - the <host> name
# for a non-root user and for root
#
# So the following variables can be defined:
#   - user_color_user
#   - at_color_user
#   - host_color_user
#
#   - user_color_root
#   - at_color_root
#   - host_color_root
#
# every variable definition should be 'local'
#
# The colors are defined in this order <user>, <at>, <host> so if a color
# is not defined the precedent is used.
# No color equals to white.

case "$(hostname)" in
  'inara')
      user_color_user="${FX[bold]}${red}"
      at_color_root="${FX[bold]}${FG[031]}"

      user_color_user="${FX[bold]}${FG[031]}"
      ;;
  'judge')
      user_color_user="${green}"
      at_color_user="${white}"
      host_color_user="${green}"
      ;;
  'arena')
      user_color_user="${red}"
      at_color_user="${white}"
      host_color_user="${green}"
      ;;
 *)
      ;;
esac
