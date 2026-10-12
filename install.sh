#!/usr/bin/env zsh
# Bootstrap a new Mac from this repo. Every step is safe to re-run.
#
#   ./install.sh        full install
#   ./install.sh link   only (re)create the symlinks into $HOME
#
# Override these from the environment, e.g. GENERATE_GPG=1 ./install.sh
PYTHON_VERSION=${PYTHON_VERSION:-3.11.2}
GENERATE_GPG=${GENERATE_GPG:-0}

# The repo root, so the script works from any cwd.
DOTFILES=${0:a:h}

function link_file() {
  local to_link=$1
  local target=$2
  mkdir -p "$(dirname "$target")"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "refusing to replace real file/dir $target" >&2
    return 1
  fi
  ln -sfn "$to_link" "$target"
}

function link_files() {
  local dir=$1
  local file rc=0
  for file in "$DOTFILES/$dir"/*(N); do
    link_file "$file" ~/."${file:t}" || rc=1
  done
  return $rc
}

# Links every config into $HOME. Keeps going past a refused link and returns 1
# if any link could not be made.
function link_all() {
  local rc=0
  link_file "$DOTFILES/zsh/zshrc" ~/.zshrc || rc=1
  link_file "$DOTFILES/zsh/zprofile" ~/.zprofile || rc=1

  # oh-my-zsh theme. Only once oh-my-zsh is installed: creating ~/.oh-my-zsh
  # here would make its installer refuse to run later ("folder already exists").
  if [ -f ~/.oh-my-zsh/oh-my-zsh.sh ]; then
    mkdir -p ~/.oh-my-zsh/custom/themes
    link_file "$DOTFILES/zsh/miguelfrde.zsh-theme" ~/.oh-my-zsh/custom/themes/miguelfrde.zsh-theme || rc=1
  fi

  # NeoVim
  link_file "$DOTFILES/nvim" ~/.config/nvim || rc=1

  # Ghostty reads the macOS default location first, and keys there override the
  # XDG one, so only that one is linked.
  link_file "$DOTFILES/ghostty/config.ghostty" \
    "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty" || rc=1

  # Shell dotfiles (aliases, exports, functions, hushlogin, sqliterc, tmux.conf) and git
  link_files 'dotfiles' || rc=1
  link_files 'git' || rc=1

  # GPG agent (gpg wants ~/.gnupg to be 700)
  mkdir -p ~/.gnupg && chmod 700 ~/.gnupg
  link_file "$DOTFILES/gpg/gpg-agent.conf" ~/.gnupg/gpg-agent.conf || rc=1
  return $rc
}

if [ "$1" = "link" ]; then
  link_all
  exit $?
fi

# Install Homebrew and put it on PATH for the rest of this script (the
# installer does not do that; ~/.zprofile does it for new shells).
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install Rosetta. Nothing in the Brewfile needs it, but apps installed outside
# of it still do (Intel-only games, etc.).
if ! /usr/bin/pgrep -q oahd; then
  sudo softwareupdate --install-rosetta --agree-to-license
fi

# Install brew packages
brew bundle install --file "$DOTFILES/packages/Brewfile"

# Install the latest Python version (-s skips it when already installed)
pyenv install -s "$PYTHON_VERSION"
pyenv global "$PYTHON_VERSION"

# Install useful fzf key bindings without prompting or touching rc files
# (zshrc already sources ~/.fzf.zsh).
"$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish

# Install oh-my-zsh. --unattended already implies RUNZSH=no CHSH=no. KEEP_ZSHRC
# only keeps a ~/.zshrc that already exists (otherwise the installer writes its
# template as a real file, which link_all would then refuse to replace), so the
# repo zshrc is linked first. The guard checks the file, not the directory, so
# an earlier `./install.sh link` cannot make this step look done.
link_file "$DOTFILES/zsh/zshrc" ~/.zshrc
if [ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]; then
  KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Rust. zshrc sources ~/.cargo/env, so rustup does not need to edit rc files.
if [ ! -x ~/.cargo/bin/rustup ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi

# tmux plugin manager (run Prefix + I inside tmux afterwards)
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Link everything into $HOME
link_all

# Authorize github
if ! gh auth status >/dev/null 2>&1; then
  gh auth login
fi

# Pick up the linked gpg-agent.conf
gpgconf --kill gpg-agent

# Generate a GPG key for signing git commits. Only when asked: ~/.gitconfig is a
# symlink into this repo, so `git config --global` rewrites the committed key.
if [ "$GENERATE_GPG" = 1 ]; then
  gpg --full-generate-key
  gpg_key_id=$(gpg --list-secret-keys --keyid-format=long | rg 'sec\s+\w+/(\w+) ' -or '$1' | head -n 1)
  if [ -n "$gpg_key_id" ]; then
    git config --global user.signingkey "$gpg_key_id"
    gpg --armor --export "$gpg_key_id"
    echo 'Add this key to your GitHub account: Settings > SSH and GPG keys'
  else
    echo 'No GPG secret key found; user.signingkey was left unchanged' >&2
  fi
fi
