# ZSH Theme - Preview: http://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

source "$ZSH_CUSTOM/themes/hosts.themes"

if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]'
    user_host+='${user_color_root}%}%n'
    user_host+='${at_color_root}@'
    user_host+='${host_color_root}%m'
    user_host+='%{$reset_color%}'
    local user_symbol='#'
else
    local user_host='%{$terminfo[bold]'
    user_host+='${user_color_user}%}%n'
    user_host+='${at_color_user}@'
    user_host+='${host_color_user}%m'
    user_host+='%{$reset_color%}'
    local user_symbol='$'
fi

local current_dir='%{$terminfo[bold]$fg[blue]%}%~%{$reset_color%}'
local rvm_ruby=''
if which rvm-prompt &> /dev/null; then
  rvm_ruby='%{$fg[red]%}'
  rvm_ruby+='$([ ! -z "$(rvm-prompt i v g)" ] && echo "‹$(rvm-prompt i v g)›" || \
                  ([ "$(dirname $(which ruby))" == "/usr/bin" ] && echo "‹system›"))'
  rvm_ruby+='%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    rvm_ruby='%{$fg[red]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
  fi
fi
local git_branch='$(git_prompt_info)%{$reset_color%}'

PROMPT="╭─${user_host} ${current_dir} ${rvm_ruby} ${git_branch}
╰─%B${user_symbol}%b "
RPS1="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"