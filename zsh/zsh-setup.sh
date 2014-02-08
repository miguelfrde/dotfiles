
echo "Installing oh-my-zsh..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

echo "Installing zsh-syntax-highlighting..."
mkdir ~/.oh-my-zsh/custom/plugins 
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins

echo "Installing zsh miguelfrde theme..."
mkdir ~/.oh-my-zsh/custom/themes
mv miguelfrde.zsh-theme ~/.oh-my-zsh/custom/themes/miguelfrde.zsh-theme

echo "Copying .zshrc..."
cp zshrc ~/.zshrc

