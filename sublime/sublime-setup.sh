#!/bin/bash

ST_FOLDER=~/Library/Application\ Support/Sublime\ Text\ 3/

# Ensure Sublime has created its Library/App Support folder
open "/Applications/Sublime Text.app"
sleep 3 
killall "Sublime Text"

echo "Creating 'sublime' symlink..."
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/sublime

echo "Installing ST Package Control..."
curl -L -o "Package Control.sublime-package" https://sublime.wbond.net/Package%20Control.sublime-package
mv "Package Control.sublime-package" "$ST_FOLDER/Installed Packages"

echo "Copy ST Settings..."
cp $SETUP_DIR/sublime/Preferences.sublime-settings "$ST_FOLDER/Packages/User/"
cp $SETUP_DIR/sublime/"Package Control.sublime-settings" "$ST_FOLDER/Packages/User/"
