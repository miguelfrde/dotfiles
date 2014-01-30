
# Don't show default PS1 from virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=yes

# Small modification from oh-my-zsh function
function git_prompt_info_miguel {
    if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]
    then
        ref=$(command git symbolic-ref HEAD 2> /dev/null)  || ref=$(command git rev-parse --short HEAD 2> /dev/null)  || return
        echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
    fi
}

function get_venv {
    local venv=$(basename "$VIRTUAL_ENV")
    if [ -n "$venv" ]; then
        echo "(venv:$venv)"
    fi
}

red=$FG[009]
orange=$FG[172]
purple=$FG[141]
yellow=$FG[190]
green=$FG[034]

# Inspired on RobbyRussell theme
local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"

PROMPT="
${ret_status}\
%{$red%}%n\
%{$reset_color%}@\
%{$purple%}%m\
%{$reset_color%}:\
%{$orange%}%~\
%{$reset_color%}\
\$(git_prompt_info_miguel)\
%{$reset_color%}
λ "

RPROMPT="%{$fg[magenta]%}\$(get_venv)%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_CLEAN="%{$green%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$yellow%}"
GIT_STATUS="%{ZSH_THEME_GIT_PROMPT_CLEAN%}%{ZSH_THEME_GIT_PROMPT_DIRTY%}"
ZSH_THEME_GIT_PROMPT_PREFIX=" on git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
