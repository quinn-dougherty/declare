#!/usr/bin/env sh

# Don't forget also to edit path to `xmobar` in `xmonad.hs`

pushd ~/projects/declare/common/modules/desktops/xmonad
HERE=$(pwd)
rm -rf ~/.xprofile
rm -rf ~/.config/xmonad/xmonad.hs
ln -s $HERE/xprofile ~/.xprofile
ln -s $HERE/xmonad.hs ~/.config/xmonad/xmonad.hs
popd
