dotfiles
========

My OSX dotfiles configuration.

Included
--------

- install.sh: this is the main script, run it to install: Xcode Command Line Tools, Homebrew and its packages, pip and its packages, update Gem and installs some gems, my Sublime Text configuration, oh-my-zsh and setup the shell environment.

- osx.sh: run it to update preferences of the following apps: Finder, Dock, Safari, Mail, Activity Monitor, Transmission and other OSX settings.

- common/*: contains exports, useful functions, aliases, my sqliterc and the file .hushlogin.

- bash/*: includes all my ~/.bash_profile configuration. Note: I no longer use bash (I prefer zsh), so I won't be updating this folder anymore.

- vim/*: includes my vimrc and a script to setup my vim: vundle, plugins and .vimrc.

- zsh/*: includes my ~/.zshrc and my custom zsh prompt theme.

- git/*: includes my ~/.gitconfig and my ~/.gitignore

- packages/*: install.sh uses the files contained in here to install all gems and pip, npm & brew packages.

- sublime/*: Sublime Text preferences file, ST Package Manager settings file and a script to install ST Package Manager and setup Sublime Text.

This will be installed along with many python, node and brew packages, casks and gems:

- [solarized colorsheme for vim](https://github.com/altercation/vim-colors-solarized)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- [taglist.vim](https://github.com/vim-scripts/taglist.vim)
- [mru.vim](https://github.com/vim-scripts/mru.vim)
- [NerdTREE](https://github.com/scrooloose/nerdtree)
- [syntastic](https://github.com/scrooloose/syntastic)
- [jedi-vim](https://github.com/davidhalter/jedi-vim)
- [tcomment](https://github.com/tomtom/tcomment_vim)
- [tagbar](https://github.com/majutsushi/tagbar)

Prompt
------

Shows the current branch on the current directory if the directory belongs to a git repository. If the branch is dirty, then it's name will appear yellow, otherwise it will appear green.

!["Pretty terminal"](https://dl.dropboxusercontent.com/u/17055504/prompt.png)

Install
-------

Using git:

```
$ git clone https://github.com/miguelfrde/dotfiles && cd dotfiles && source install.sh
```

Without git:

```
$ curl -L -o tmp.zip https://github.com/miguelfrde/dotfiles/archive/master.zip && unzip -q tmp.zip && rm tmp.zip
$ cd dotfiles-master && source install.sh
```

This repo was inspired in part by Mathias Bynens' great [dotfiles](https://github.com/mathiasbynens/dotfiles).
