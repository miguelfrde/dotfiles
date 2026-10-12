# Don't show default PS1 from virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=yes

# Small modification from oh-my-zsh function
function git_prompt_info_miguel {
    if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]
    then
        local ref
        ref=$(command git symbolic-ref HEAD 2> /dev/null)  || ref=$(command git rev-parse --short HEAD 2> /dev/null)  || return
        echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)${${ref#refs/heads/}//\%/%%}$ZSH_THEME_GIT_PROMPT_SUFFIX"
    fi
}

function get_venv {
    local venv=${VIRTUAL_ENV:t}
    if [ -n "$venv" ]; then
        echo " (venv:$venv)"
    fi
}

local yellow=$FG[190]
local green=$FG[034]
local blue=$FG[004]

# Inspired on RobbyRussell theme
local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"

PROMPT="
${ret_status}\
%{$blue%}%3~\
%{$reset_color%}\
\$(git_prompt_info_miguel)\
%{$reset_color%}\
%{$fg[magenta]%}\$(get_venv)%{$reset_color%}
λ "


ZSH_THEME_GIT_PROMPT_CLEAN="%{$green%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$yellow%}"
ZSH_THEME_GIT_PROMPT_PREFIX=" on :"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
