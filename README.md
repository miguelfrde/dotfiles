dotfiles
========

My OSX dotfiles configuration.

Included
--------

- install.sh: this is the main script, run it to install: Xcode Command Line Tools, Homebrew and its packages, pip and its packages, update Gem and installs some gems, Java 1.7, my Sublime Text configuration and setup the bash environment.

- osx.sh: run it to update preferences of the following apps: Finder, Dock, Safari, Mail, Activity Monitor, Transmission and other OSX settings.

- vimrc: my ~/.vimrc (not a lot of configurations, I use Sublime Text more).

- bash/*: includes all my ~/.bash_profile configuration: exports, aliases, functions and the file .hushlogin.

- git/*: includes my ~/.gitconfig and my ~/.gitignore

- packages/*: install.sh uses the files contained in here to install all gems and pip & brew packages.

- sublime/*: Sublime Text preferences file, ST Package Manager settings file and a script to install ST Package Manager and setup Sublime Text.



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
