# shellcheck disable=SC1090,SC1091,SC2016,SC2034,SC2148,SC2154,SC2168
# ZSH Theme

function _theme() {
  unset -f _theme

  source "$ZSH_CUSTOM/themes/hosts.themes"

  local c
  local a
  local h

  local user_symbol

  # shellcheck disable=SC2016,SC2154
  if [[ $UID -eq 0 ]]; then
    c="${user_color_root}"
    a="${at_color_root}"
    h="${host_color_root}"

    user_symbol='#'
  else
    c="${user_color_user}"
    a="${at_color_user}"
    h="${host_color_user}"

    user_symbol='$'
  fi

  local user_host='%{$terminfo[bold]%}'$c'%n'$a'@'$h'%m$reset_color%}'
  local current_dir='%{$terminfo[bold]${fg[blue]}%}%~%{$reset_color%}'
  local return_code="%(?..%{${fg[red]}%}%? ↵%{$reset_color%})"

  function _gitp() {
    unset -f _gitp

    local git_green="${FG[113]}"

    # shellcheck disable=SC2154
    ZSH_THEME_GIT_PROMPT_DIRTY=" ${fg[red]}✗"
    ZSH_THEME_GIT_PROMPT_CLEAN=" ${FX[bold]}✓$reset_color"
    ZSH_THEME_GIT_PROMPT_PREFIX=" $git_green‹"
    ZSH_THEME_GIT_PROMPT_SUFFIX="$git_green›$reset_color"

  }
  local gitp=''
  _gitp
  gitp='%{$(git_prompt_info)$reset_color%}'

  function _venvp() {
    unset -f _venvp
    local venvp=''

    venvp+='%{$fg[yellow]'
    venvp+='$(virtualenv_prompt_info | sed -r "s#\[(.*)\]# ‹\1›#")'
    venvp+='$reset_color%}'

    echo "$venvp"
  }

  function rvm_prompt_active() {
    return 1
  }

  function rvm_activate_prompt() {
    function rvm_prompt_active() {
      return 0
    }
  }

  function rvm_deactivate_prompt() {
    function rvm_prompt_active() {
      return 1
    }
  }

  function _rvmp() {

    local rvmp=''
    if command -v rvm-prompt &> /dev/null; then
      rvmp='%{$fg[red]%}'
      rvmp+='$($(rvm_prompt_active) && ([ ! -z "$(rvm-prompt i v g)" ] && echo " ‹$(rvm-prompt i v g)›" || \
                      ([[ "x$(dirname $(command -v ruby))" == "x/usr/bin" ]] && echo " ‹system›")))'
      rvmp+='%{$reset_color%}'
    elif command -v rbenv &> /dev/null; then
      rvmp='%{$fg[red]%} ‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
    fi

    echo "$rvmp"
  }

  PROMPT="╭─${user_host} ${current_dir}$(_venvp)$(_rvmp)${gitp}"
  PROMPT+="
╰─%B${user_symbol}%b "

  RPS1="%B${return_code}%b"

  # we need tp cleanup because we are not sure _venv, _rvm are called
  function _cleanup() {
    unset -f _venvp
    unset -f _rvmp

    unset -f _cleanup
  }

  _cleanup
}

_theme
