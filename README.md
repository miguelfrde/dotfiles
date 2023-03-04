# dotfiles

My dotfiles configuration.

## Included

- `alacritty/*`: contains my configuration for the Alacritty terminal emulator.
- `dotfiles/*`: contains useful shell stuff such as aliases, exports, functions and my tmux.conf.
- `git/*`: contains my git config.
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

### Neovim

It should bootstrap packer automatically the first time it's opened.
Mason is also configured to ensure LSPs are installed.

Also configure to use the Hack Nerd Font (Settings > Profiles > Text > Hack Nerd Font).

### Tmux

Run Prefix + `I` the first time it's opened to install plugins.

### OS X

My `osx.sh` is entirely out of date, I should update it.
