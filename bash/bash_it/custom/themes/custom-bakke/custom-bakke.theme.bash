#!/usr/bin/env bash
# shellcheck disable=SC2034,SC2154

git_green="${FG[113]}"
GIT_THEME_PROMPT_DIRTY=" ${red}✗"
GIT_THEME_PROMPT_CLEAN=" ${FG[bold]}${git_green}✓${reset_color}"
GIT_THEME_PROMPT_PREFIX="${git_green}‹"
GIT_THEME_PROMPT_SUFFIX="${git_green}›${reset_color} "

VIRTUALENV_THEME_PROMPT_PREFIX='‹'
VIRTUALENV_THEME_PROMPT_SUFFIX='›'

# shellcheck disable=SC1090,SC1091
{
source "$HOME/.bash_it/custom/themes/colors.bash"
source "$HOME/.bash_it/custom/themes/hosts.bash"
}

parse_git_dirty () {
    local STATUS=''
    local -a FLAGS
    FLAGS=('--porcelain')
    if [[ "$(command git config --get oh-my-zsh.hide-dirty)" != "1" ]]
    then
        if [[ $POST_1_7_2_GIT -gt 0 ]]
        then
            FLAGS+='--ignore-submodules=dirty'
        fi
        if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" = "true" ]]
        then
            FLAGS+='--untracked-files=no'
        fi
        STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
    fi
    if [[ -n $STATUS ]]
    then
        echo "$GIT_THEME_PROMPT_DIRTY"
    else
        echo "$GIT_THEME_PROMPT_CLEAN"
    fi
}

function git_prompt_info () {
    local ref
    if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]
    then
        ref=$(command git symbolic-ref HEAD 2> /dev/null)  || ref=$(command git rev-parse --short HEAD 2> /dev/null)  || return 0
        echo "$GIT_THEME_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$GIT_THEME_PROMPT_SUFFIX"
    fi
}

# shellcheck disable=SC1117,SC2016,SC2154
function prompt_command() {
     if [[ $UID -eq 0 ]]; then
        user_host='${FX[bold]}'
        user_host+='${user_color_root}\u'
        user_host+='${at_color_root}@'
        user_host+='${host_color_root}\h'
        user_host+="${reset_color}"
        user_symbol='#'
    else
        user_host='${FX[bold]}'
        user_host+='${user_color_user}\u'
        user_host+='${at_color_user}@'
        user_host+='${host_color_user}\h'
        user_host+="${reset_color}"
        user_symbol='$'
    fi

    local current_dir="${blue}"
    current_dir+='${FX[bold]}\w'
    current_dir+="${reset_color}"

    local virtualenv_status
    virtualenv_status="${yellow}$(virtualenv_prompt)${reset_color} "
    if [[ -z "${virtualenv_status// }" ]]; then
        virtualenv_status=''
    fi

    local rvm_ruby="${red}"
    if which rvm-prompt &> /dev/null; then
        rvm_ruby+='$([ ! -z "$(rvm-prompt i v g)" ] && echo "‹$(rvm-prompt i v g)›" || \
                  ([[ "x$(dirname $(which ruby))" == "x/usr/bin" ]] && echo "‹system›"))'
    else
        if which rbenv &> /dev/null; then
            rvm_ruby+='‹$(rbenv version | sed -e "s/ (set.*$//")›'
        fi
    fi
    rvm_ruby+="${reset_color} "
    if [[ -z "${rvm_ruby// }" ]]; then
        rvm_ruby=''
    fi

    local git_branch
    git_branch="$(git_prompt_info)${reset_color}"


    PS1="\n╭─${user_host} ${current_dir} ${virtualenv_status}${rvm_ruby}"
    PS1+="${git_branch}\n"
    PS1+="╰─${FG[bold]}${user_symbol}${FX[reset]} "
}

safe_append_prompt_command prompt_command
