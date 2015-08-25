echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Installing zsh-syntax-highlighting..."
mkdir -p ~/.oh-my-zsh/custom/plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins

echo "Installing zsh miguelfrde theme..."
mkdir -p ~/.oh-my-zsh/custom/themes
cp miguelfrde.zsh-theme ~/.oh-my-zsh/custom/themes

echo "Installing hub completion.."
mkdir -p .zsh
curl https://github.com/github/hub/blob/master/etc/hub.zsh_completion >  ~/.zsh/_hub

echo "Linking .zshrc..."
ln -sf `pwd`/zsh/zshrc ~/.zshrc
