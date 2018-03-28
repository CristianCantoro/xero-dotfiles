#!/usr/bin/env bash
# shellcheck disable=SC2034,SC2154

# shellcheck disable=SC1090,SC1091
{
source "$HOME/.bash_it/custom/themes/colors.bash"
source "$HOME/.bash_it/custom/themes/hosts.bash"
}

git_green="\[${FG[113]}\]"
reset_color="\[${FX[reset]}\]"

GIT_THEME_PROMPT_DIRTY=" ${FG[001]}✗"
GIT_THEME_PROMPT_CLEAN=" ${FX[bold]}${git_green}✓${reset_color}"
GIT_THEME_PROMPT_PREFIX="${git_green}‹"
GIT_THEME_PROMPT_SUFFIX="${git_green}›${reset_color} "

VIRTUALENV_THEME_PROMPT_PREFIX='‹'
VIRTUALENV_THEME_PROMPT_SUFFIX='›'

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
    if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
        ref=$(command git symbolic-ref HEAD 2> /dev/null)  || ref=$(command git rev-parse --short HEAD 2> /dev/null)  || return 0
        echo "$GIT_THEME_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$GIT_THEME_PROMPT_SUFFIX"
    fi
}

function git_prompt() {
    local ref
    if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
        ref=$(command git symbolic-ref HEAD 2> /dev/null)  || ref=$(command git rev-parse --short HEAD 2> /dev/null)  || return 0
        echo "‹${ref#refs/heads/} X›"
    fi
}

# shellcheck disable=SC1117,SC2016,SC2154
function prompt_command() {
    return_code="$?"
    return_status=''
    if [ $return_code != 0 ]; then
        return_status+="${FX[bold]}${FG[001]}$return_code"
    else
        return_status+="${FX[bold]}${FG[002]} "
    fi
    return_status+=" ↵${reset_color}"

    if [[ $UID -eq 0 ]]; then
        user_host='\[${FX[bold]}\]'
        user_host+='\[${user_color_root}\]\u'
        user_host+='\[${at_color_root}\]@'
        user_host+='\[${host_color_root}\]\h'
        user_host+="${reset_color}"
        user_symbol='\#'
    else
        user_host='\[${FX[bold]}\]'
        user_host+='\[${user_color_user}\]\u'
        user_host+='\[${at_color_user}\]@'
        user_host+='\[${host_color_user}\]\h'
        user_host+="${reset_color}"
        user_symbol='\$'
    fi

    local current_dir="\[${FG[004]}\]"
    current_dir+='${FX[bold]}\w'
    current_dir+="${reset_color}"

    local virtualenv_status
    virtualenv_status=" \[${FG[003]}\]$(virtualenv_prompt)${reset_color} "
    if [[ -z "${virtualenv_status// }" ]]; then
        virtualenv_status=''
    fi

    local rvm_ruby="\[${FG[001]}\]"
    local rvm_string=''
    if which rvm-prompt &> /dev/null; then
        rvm_ruby+='$([ ! -z "$(rvm-prompt i v g)" ] && echo "‹$(rvm-prompt i v g)›" || \
                  ([[ "x$(dirname $(which ruby))" == "x/usr/bin" ]] && echo "‹system›"))'
        rvm_string+="$([ ! -z "$(rvm-prompt i v g)" ] && echo "‹$(rvm-prompt i v g)›" || \
                  ([[ "x$(dirname "$(which ruby)")" == "x/usr/bin" ]] && echo "‹system›"))"
    else
        if which rbenv &> /dev/null; then
            rvm_ruby+='‹$(rbenv version | sed -e "s/ (set.*$//")›'
            rvm_string+="‹$(rbenv version | sed -e "s/ (set.*$//")›"
        fi
    fi
    rvm_ruby+="${reset_color} "
    rvm_string+=" "
    if [[ -z "${rvm_ruby// }" ]]; then
        rvm_ruby=''
        rvm_string=''
    fi


    local git_branch
    git_branch="$(git_prompt_info)${reset_color}"

    current_dir_path=$(dirs +0)
    host="$(echo "$HOSTNAME" |  cut -d'.' -f1)"
    initial_string="$USER@$host ${current_dir_path} $(virtualenv_prompt) ${rvm_string}"
    initial_string+="$(git_prompt)"
    final_string="$return_code ↵"

    # echo "initial_string: $initial_string"
    # echo "final_string: $final_string"

    nPS=$((${#initial_string}+${#final_string}+3))
    spaces=$(printf %"$((COLUMNS-nPS))"s)

    PS1="${reset_color}╭─${user_host} ${current_dir}${virtualenv_status}${rvm_ruby}"
    PS1+="${git_branch}${spaces}${return_status}\n"
    PS1+="╰─${FG[bold]}${user_symbol}${reset_color} "
}

safe_append_prompt_command prompt_command
