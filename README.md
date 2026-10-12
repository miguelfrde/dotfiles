# dotfiles

My dotfiles configuration.

## Included

- `dotfiles/*`: contains useful shell stuff such as aliases, exports, functions, sqliterc and my tmux.conf.
- `ghostty/*`: contains my configuration for the Ghostty terminal emulator.
- `git/*`: contains my git config.
- `gpg/*`: contains my gpg-agent config (pinentry-mac, so passphrases go to the keychain).
- `nvim/*`: contains my NeoVim configuration.
- `packages/*`: contains software I like to install.
- `zsh/*`: contains my ZSH configuration including my oh-my-zsh theme.


## Install

The dotfiles will be linked, so they will be edited from the place where you clone the repo. Therefore, cd to
your personal development/github directory before running the `install.sh` script.

```
$ mkdir -p ~/development
$ cd ~/development
$ git clone https://github.com/miguelfrde/dotfiles && cd dotfiles
$ ./install.sh
```

Every step is safe to re-run. `./install.sh link` only (re)creates the symlinks, which is all that is
needed after adding a file to the repo. Set `GENERATE_GPG=1` to also generate a GPG signing key for
git commits (it rewrites the key in `git/gitconfig`, so it is off by default).

### Neovim

lazy.nvim bootstraps itself on first launch; plugin versions are pinned in `nvim/lazy-lock.json`.
Language servers come from the Brewfile (lua-language-server) and rustup (rust-analyzer).

### Ghostty

The config is linked to `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty`, the
location Ghostty reads first on macOS. It picks up Hack Nerd Font Mono from `ghostty/config.ghostty`.

### Tmux

Run Prefix + `I` the first time it's opened to install plugins.

### macOS

`osx.sh` sets my system defaults (Finder, Dock, trackpad, Safari, screenshots...). Run it separately;
it asks for the computer name and for sudo.
