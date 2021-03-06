echo "Linking .vimrc..."
ln -sf `pwd`/vim/vimrc ~/.vimrc

echo "Installing vundle and vim plugins..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +BundleInstall +qall

echo "Install powerline fonts for vim-airline..."
git clone https://github.com/powerline/fonts
./fonts/install.sh
rm -rf fonts
echo "NOTE: set iTerm > Profile > Text > Non ASCII font to be a powerline one"
