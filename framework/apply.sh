#!/usr/bin/env sh
pushd ~/Dropbox/TmpDropboxFixing/configuration.nix
sudo nixos-rebuild switch --flake .#
popd
