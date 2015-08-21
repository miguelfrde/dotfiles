dotfiles
========

My OSX dotfiles configuration.

Included
--------

- install.sh: this is the main script, run it to install: Xcode Command Line Tools, Homebrew and its packages, pip and its packages, update Gem and installs some gems, my Sublime Text configuration, oh-my-zsh and setup the shell environment. OUTDATED.

- osx.sh: run it to update preferences of the following apps: Finder, Dock, Safari, Mail, Activity Monitor, Transmission and other OSX settings. OUTDATED.

- common/*: contains exports, useful functions, aliases, my sqliterc and the file .hushlogin.

- vim/*: includes my vimrc and a script to setup my vim: vundle, plugins and .vimrc. SETUP OUTDATED.

- zsh/*: includes my ~/.zshrc and my custom zsh prompt theme. SETUP OUTDATED.

- git/*: includes my ~/.gitconfig and my ~/.gitignore

- packages/*: install.sh uses the files contained in here to install all gems and pip, npm & brew packages. BREW OUTDATED.


Prompt
------

Shows the current branch on the current directory if the directory belongs to a git repository. If the branch is dirty, then it's name will appear yellow, otherwise it will appear green.

!["Pretty terminal"](https://dl.dropboxusercontent.com/u/17055504/prompt.png)

Install
-------

The dotfiles will be linked, so they will be edited from the place where you clone the repo. Therefore, cd to your personal development/github directory before running the `install.sh` script.

```
$ git clone https://github.com/miguelfrde/dotfiles && cd dotfiles && source install.sh
```

This repo was inspired in part by Mathias Bynens' great [dotfiles](https://github.com/mathiasbynens/dotfiles).
