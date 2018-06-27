# shellcheck disable=SC1090,SC2016,SC2148,SC2154
# ZSH Theme

function _theme() {
  unset -f _theme

  # import per-host prompt color definitions
  source "$ZSH_CUSTOM/themes/hosts.themes"

  local c
  local a
  local h

  local user_symbol

  if [[ $UID -eq 0 ]]; then
    # user is root
    c="${user_color_root}"
    a="${at_color_root}"
    h="${host_color_root}"

    user_symbol='#'
  else
    # user is not root
    c="${user_color_user}"
    a="${at_color_user}"
    h="${host_color_user}"

    user_symbol='$'
  fi

  # user@host cwd
  local user_host='%{$terminfo[bold]%}'$c'%n'$a'@'$h'%m$reset_color%}'
  local current_dir='%{$terminfo[bold]${fg[blue]}%}%~%{$reset_color%}'

  # git
  # if in repo:
  #  - clean: ‹branch ✓›
  #  - dirty: ‹branch ✗›
  # else empty.
  function _gitp() {
    unset -f _gitp

    local git_green="${FG[113]}"

    # shellcheck disable=SC2034
    {
    ZSH_THEME_GIT_PROMPT_DIRTY=" ${fg[red]}✗"
    ZSH_THEME_GIT_PROMPT_CLEAN=" ${FX[bold]}✓$reset_color"
    ZSH_THEME_GIT_PROMPT_PREFIX=" $git_green‹"
    ZSH_THEME_GIT_PROMPT_SUFFIX="$git_green›$reset_color"
    }
  }
  local gitp=''
  _gitp
  gitp='%{$(git_prompt_info)$reset_color%}'

  # virtualenv
  # if virtualenv is active: ‹virtualenv›. else empty.
  function _venvp() {
    unset -f _venvp
    local venvp=''

    venvp+='%{$fg[yellow]'
    venvp+='$(virtualenv_prompt_info | sed -r "s#\[(.*)\]# ‹\1›#")'
    venvp+='$reset_color%}'

    echo "$venvp"
  }

  # helper functions for ruby prompt
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

  # ruby
  # if rvm_prompt_active (rvm_activate_prompt/rvm_deactivate_prompt):
  #  - if rvm: ‹ruby_version› or ‹system›
  #  - if rbenv: ‹ruby_version›
  # else empty.
  function _rvmp() {

    local rvmp=''
    if command -v rvm-prompt &> /dev/null; then
      rvmp='%{$fg[red]%}'

      rvmp+='$($(rvm_prompt_active) &&
                ([ ! -z "$(rvm-prompt i v g)" ] &&
                  echo " ‹$(rvm-prompt i v g)›"
                ) ||
                ([[ "x$(dirname $(command -v ruby))" == "x/usr/bin" ]] &&
                  echo " ‹system›"
                )
              )'
      rvmp+='%{$reset_color%}'
    elif command -v rbenv &> /dev/null; then
      rvmp='%{$fg[red]%} ‹$(rbenv version |
              sed -e "s/ (set.*$//")›%{$reset_color%}'
    fi

    echo "$rvmp"
  }

  # prompt: user@host cwd ‹virtualenv› ‹ruby› ‹git›
  PROMPT="╭─${user_host} ${current_dir}$(_venvp)$(_rvmp)${gitp}"
  PROMPT+="
╰─%B${user_symbol}%b "

  # if the previous command return code is non-zero print it in red
  local return_code="%(?..%{${fg[red]}%}%? ↵%{$reset_color%})"
  # shellcheck disable=SC2034
  RPS1="%B${return_code}%b"

  function _cleanup() {
    unset -f _cleanup

    unset -f _venvp
    unset -f _rvmp
  }

  _cleanup
}

_theme
