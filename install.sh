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
    xcode-select --install
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

echo_title "Update Ruby Gem and installed gems"
sudo gem update --system
sudo gem update

echo_title "Gem stuff"
cd packages
sudo gem install bundler
sudo bundle install
cd $SETUP_DIR
echo_done "Gem stuff"

echo_title "Node packages"
source packages/Npmfile
echo_done "Node packages"

echo_title "Sublime configuration"
source sublime/sublime-setup.sh
echo_done "Sublime configuration"

echo_title "some configurations"

# As stated in R caveats, do this to use brew R with RStudio
sudo ln -s "/usr/local/opt/r/R.framework" /Library/Frameworks

sudo bash -c "echo /usr/local/bin/bash >> /etc/shells"
sudo bash -c "echo /usr/local/bin/bash >> /private/etc/shells"
sudo bash -c "echo /usr/local/bin/zsh >> /etc/shells"
sudo bash -c "echo /usr/local/bin/zsh >> /private/etc/shells"

echo_done "some configurations"

echo_title "oh-my-zsh!"
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
echo_done "oh-my-zsh"

echo_title "zsh stuff: miguelfrde theme and zsh-syntax-highlighting"
mkdir ~/.oh-my-zsh/custom/themes
mkdir ~/.oh-my-zsh/custom/plugins 
mkdir ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
mv ~/.miguelfrde.zsh-theme ~/.oh-my-zsh/custom/themes/miguelfrde.zsh-theme
cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting
cd $SETUP_DIR
echo_done "zsh stuff: miguelfrde theme and zsh-syntax-highlighting"

echo_title "vim stuff"
mkdir -p ~/.vim/colors
curl -o solarized.vim https://raw2.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
mv solarized.vim ~/.vim/colors
echo_done "vim stuff"

echo_title "dotfiles"
copy_dotfiles "common"
copy_dotfiles "bash"
copy_dotfiles "git"
copy_dotfiles "zsh"
echo_done "dotfiles"

#source ~/.bash_profile
#source ~/.zshrc

echo_title "OSX configurations"
source osx.sh
echo_done "OSX configurations"

echo "Changing shell to zsh..."
chsh -s `which zsh`

echo "Setup finished. You may need to restart the computer."
read -p "Press [Enter] to exit this utility..."

exit 0
