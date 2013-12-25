#!/bin/bash

function echo_title() {
    echo "\n===== Install $1 ====="
}

function echo_done() {
    echo "$1 installed!"
}

r="$(pkgutil --pkg-info=com.apple.pkg.CLTools_Executables 2>/dev/null | grep -v version)"

if [ "$r" == '' ]; then
    echo "Xcode Coommand Line Tools needed. Installing now"
    exit 1
fi

clear

SETUP_DIR="$(pwd)"
JAVA_URL="http://download.oracle.com/otn-pub/java/jdk/7u45-b18/jdk-7u45-macosx-x64.dmg"

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

echo_title "Java 1.7"
# Thanks to: https://gist.github.com/hgomez/4697585
curl -L --header "Cookie: s_nr=1359635827494; s_cc=true; gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjdk6downloads-1902814.html; s_sq=%5B%5BB%5D%5D; gpv_p24=no%20value" \
    $JAVA_URL -o tmp.dmg
hdiutil attach -mountpoint ./tmp_installer tmp.dmg
sudo installer -pkg ./tmp_installer/*.pkg -target /
hdiutil detach ./tmp_installer
rm tmp.dmg
echo_done "Java 1.7"

echo_title "Sublime configuration"
source sublime/sublime-setup.sh
echo_done "Sublime configuration"

echo "===== Set up environment ====="

cp bash_profile ~/.bash_profile
cp vimrc ~/.vimrc
cp gitignore ~/.gitignore
cp gitconfig ~/.gitconfig

source ~/.bash_profile
source osx.sh

git config --global core.excludesfile ~/.gitignore

echo "Setup finished. You may need to restart the computer."
read -p "Press [Enter] to exit this utility..."

clear
