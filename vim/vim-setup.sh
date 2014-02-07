
echo "Installing solarized color scheme for Vim..."
mkdir -p ~/.vim/colors
curl -o solarized.vim https://raw2.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
mv solarized.vim ~/.vim/colors

echo "Copying .vimrc..."
cp vimrc ~/.vimrc

echo "Installing vundle and vim plugins..."
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
