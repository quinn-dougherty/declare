#!/usr/bin/env sh

# Don't forget also to edit path to `xmobar` in `xmonad.hs`

pushd ~/Dropbox/dotfiles/framework/system/services/x
HERE=$(pwd)
ln -s $HERE/xprofile ~/.xprofile
ln -s $HERE/xmonad.hs ~/.config/xmonad/xmonad.hs
popd
