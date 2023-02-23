# Override these.
local PYTHON_VERSION='3.11.2'
local GENERATE_GPG=0

function link_file() {
  local to_link=$1
  local target=$2
  rm $target
  ln -s $to_link $target
}

function link_files() {
  local dir=$1
  for file in $(ls $dir); do
    link_file `pwd`/$dir/$file ~/.$file
  done
}

# Install Homebrew
/bin/bash -c '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)'

# Install brew packages
brew bundle install --file packages/Brewfile

# Install the latest Python version
pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION

# Install useful fzf key bindings
$(brew --prefix)/opt/fzf/install

# Install oh-my-zsh
sh -c '$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)'
link_file `pwd`/zsh/zshrc ~/.zshrc

# Configure my oh my zsh theme
mkdir -p ~/.oh-my-zsh/custom/themes
cp zsh/miguelfrde.zsh-theme ~/.oh-my-zsh/custom/themes

# TODO: change this for Linux.
# Get the catpuccin theme for iTerm2
git clone https://github.com/catppuccin/iterm ~/.config/catppuccin-iterm

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Configure NeoVim
link_file `pwd`/nvim ~/.config/nvim

# Configure tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Link my dotfiles.
link_files 'dotfiles'
link_files 'git'

# Authorize github
gh auth login

# We'll now generate a GPG Key for signing git commits
if [ GENERATE_GPG ]
then
  gpg --full-generate-key
  local gpg_key_id=$(gpg --list-secret-keys --keyid-format=long | rg 'sec\s+\w+/(\w+) ' -or '\$1')
  git config --global user.signingkey $gpg_key_id
  gpg --armor --export $gpg_key_id
  echo 'Add this key to your GitHub account: Settings > SSH and GPG keys'
fi
