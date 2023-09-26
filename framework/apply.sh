#!/usr/bin/env sh
pushd ~/Dropbox/TmpDropboxFixing/dotfiles
sudo nixos-rebuild switch --flake .#
popd
