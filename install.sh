#!/bin/bash

function echo_title() {
    echo "\n===== Install $1 ====="
}

function echo_done() {
    echo "$1 installed!"
}

function copy_dotfiles() {
    local dir=$1
    for file in $(ls $dir); do
        cp $dir/$file ~/.$file
    done
}

r="$(pkgutil --pkg-info=com.apple.pkg.CLTools_Executables 2>/dev/null | grep -v version)"

if [ "$r" == '' ]; then
    echo "Xcode Coommand Line Tools needed. Installing now"
    exit 1
fi

clear

SETUP_DIR="$(pwd)"

echo_title "Homebrew"
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
export PATH="/usr/local/bin:/usr/local/share/python:$PATH"
echo_done "Homebrew"

echo_title "Homebrew stuff"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
brew bundle packages/Brewfile
brew unlink ruby
brew link ruby
brew cask alfred link
brew linkapps
echo_done "Homebrew stuff"

echo_title "Pip stuff"
sudo pip install -r packages/Pipfile
echo_done "Pip stuff"

echo "\n===== Update Ruby Gem and installed gems ====="
sudo gem update --system
sudo gem update

echo_title "Gem stuff"
cd packages
sudo gem install bundler
sudo bundle install
cd $SETUP_DIR
echo_done "Gem stuff"

echo_title "Sublime configuration"
source sublime/sublime-setup.sh
echo_done "Sublime configuration"

echo "===== Set up environment ====="

copy_dotfiles "bash"
copy_dotfiles "git"
cp vimrc ~/.vimrc

source ~/.bash_profile
source osx.sh

echo "Setup finished. You may need to restart the computer."
read -p "Press [Enter] to exit this utility..."

clear
