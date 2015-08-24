echo "Linking .vimrc..."
ln -sf `pwd`/vim/vimrc ~/.vimrc

echo "Installing vundle and vim plugins..."
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall


