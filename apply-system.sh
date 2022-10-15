#!/usr/bin/env sh
pushd ~/Dropbox/dotfiles
sudo nixos-rebuild switch --flake .#
popd
