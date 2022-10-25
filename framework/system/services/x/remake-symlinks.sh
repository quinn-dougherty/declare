#!/usr/bin/env sh

pushd ~/Dropbox/dotfiles/framework/system/services/x
HERE=$(pwd)
ln -s $HERE/xprofile ~/.xprofile
ln -s $HERE/xmonad.hs ~/.config/xmonad/xmonad.hs
popd
