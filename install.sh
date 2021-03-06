#!/bin/bash

function echo_title() {
  echo "\n===== Install $1 ====="
}

function echo_done() {
  echo "$1 installed!"
}

function link_dotfiles() {
  local dir=$1
  for file in $(ls $dir); do
    ln -sf `pwd`/$dir/$file ~/.$file
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
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
export PATH="/usr/local/bin:$PATH"
cd packages
brew tap 'Homebrew/bundle'
brew bundle
brew cleanup
cd $SETUP_DIR
echo_done "Homebrew"

echo_title "Pip packages"
pip3 install -r packages/Pipfile
echo_done "Pip packages"

echo_title "Ruby stuff"
rbenv install 2.5.0
rbenv global 2.5.0
gem update --system
gem update
cd packages
gem install bundler
bundle install
cd $SETUP_DIR
echo_done "Ruby"

echo_title "Node stuff"
export NVM_DIR="$HOME/.nvm"
source "/usr/local/opt/nvm/nvm.sh"
nvm install stable
#source packages/Npmfile
echo_done "Node stuff"

echo_title "Some configurations"
sudo bash -c "echo /usr/local/bin/zsh >> /etc/shells"
sudo bash -c "echo /usr/local/bin/zsh >> /private/etc/shells"
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
curl https://raw.githubusercontent.com/chriskempson/base16-iterm2/master/base16-ocean.dark.256.itermcolors > ~/Desktop/base16-ocean.dark.256.itermcolors
/usr/local/opt/fzf/install
echo "NOTE: The iTerm theme is in your desktop, load the profile on iTerm to install it..."
echo_done "Some configurations"

echo_title "zsh stuff"
source zsh/zsh-setup.sh
echo_done "zsh stuff"

echo_title "Vim stuff"
source vim/vim-setup.sh
echo_done "Vim stuff"

echo_title "dotfiles"
link_dotfiles "dotfiles"
link_dotfiles "git"
echo_done "dotfiles"

echo_title "tmux stuff"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo_done "tmux stuff"

echo_title "OSX configurations"
source osx.sh
echo_done "OSX configurations"

echo "Changing shell to zsh..."
chsh -s `which zsh`

echo "Setup finished. You may need to restart the computer."
read -p "Press [Enter] to exit this utility..."

exit 0
