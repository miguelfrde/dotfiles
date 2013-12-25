dotfiles
========

My OSX dotfiles configuration.

Included
--------

- install.sh: this is the main script, run it to install: Xcode Command Line Tools, Homebrew and its packages, pip and its packages, update Gem and installs some gems, Java 1.7, my Sublime Text configuration and setup the bash environment.

- bash_profile: my ~/.bash_profile

- gitconfig: my ~/.gitconfig

- gitignore: my ~/.gitignore

- vimrc: my ~/.vimrc (not a lot of configurations, I use Sublime Text more).

- osx.sh: run it to update preferences of the following apps: Finder, Dock, Safari, Mail, Activity Monitor, Transmission and other OSX settings.

- packages/*: install.sh uses the file contained in that directory to install all gems and pip & brew packages.

- sublime/*: Sublime Text preferences file, ST Package Manager settings file and a script to install ST Package Manager and do some other things.

This script was inspired in part by Mathias Bynens' great [dotfiles](https://github.com/mathiasbynens/dotfiles).


