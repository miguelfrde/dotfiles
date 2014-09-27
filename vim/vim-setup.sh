
echo "Installing solarized color scheme for Vim..."
mkdir -p ~/.vim/colors
curl -o solarized.vim https://raw2.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
mv solarized.vim ~/.vim/colors

echo "Copying .vimrc..."
cp vimrc ~/.vimrc

echo "Installing vundle and vim plugins..."
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall

mkdir ycm_build
cd ycm_build
cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/ycm_temp/llvm_root_dir . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
make ycm_support_libs
cd ..
rm -rf ycm_build
