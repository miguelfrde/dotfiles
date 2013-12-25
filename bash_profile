#!/bin/bash

export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share/python:$PATH

# Link Homebrew apps to /Applications, not the default ~/Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications" 

# Always show colors
export CLICOLOR=1

# Colors for ls
#   - Directory -> cyan
#   - Symlink -> magenta
#   - Socket -> bold green
#   - Pipe -> yellow
#   - Executable -> bold red
#   - Block device, character device, 
#     executable with setuid set, executable with setguid set,
#     directory writable by others, with/without sticky bit
#     -> default colors
# default: exfxcxdxbxegedabagacad
export LSCOLORS=gxFxCxDxBxegedabagacad

# Make Sublime Text default editor
export EDITOR='sublime -w'

# Don't show duplicates on 'history' and ignore commands starting with ' '
export HISTCONTROL=ignoreboth

# Easier navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"

# Always ls showing colors
alias ls='ls -G'

# Like ls -la, but with directories first
alias ll='tree --dirsfirst -ChFupDaLg 1'

# Grep coloring matches
alias grep='grep --color=auto'

# View current IP
alias ip="curl -s http://checkip.dyndns.com/ | sed 's/[^0-9\.]//g'"

# View local IP
alias localip="ipconfig getifaddr en1"

# View size of current directory
alias d="du -h -d=1"

# Used to connect to Raspberry Pi
alias rpi='ssh 192.168.2.2 -l pi' 

# Use hub
alias git=hub

# Update OSX and brew
function update() {
    echo "Find Apple software updates"
    sudo softwareupdate -i -a
    echo "Update brew and its packages"
    brew update
    brew upgrade
    brew cleanup
    echo "Update gems"
    sudo gem update --system
    sudo gem update
}

if [ -f ~/.profile ] ; then
    source ~/.profile
fi

# Enable bash-completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    source `brew --prefix`/etc/bash_completion
fi

# Update branch in prompt
function update_ps1_git() {
    color_prompt="\[\e[0;32m\]"
    color_dirty="\[\e[0;33m\]"
    color_clean="\[\e[0;36m\]"
    local branch
    local git_branch
    local branch_color
    local status=$(git status 2> /dev/null | tail -n1 | grep 'nothing to commit')
    if branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); then
        git_branch="($branch)"
    else
        git_branch=""
    fi
    if  [ "$status" = "" ]; then
        branch_color="$color_dirty" # Changes -> Yellow
    else
        branch_color="$color_clean" # No changes -> Cyan
    fi
    PS1="$color_prompt\u@\h \W $branch_color$git_branch\[\e[0m\]\$ "
}

# Always update branch in prompt before running a command
PROMPT_COMMAND="update_ps1_git; $PROMPT_COMMAND"
