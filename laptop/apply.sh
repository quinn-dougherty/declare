#!/usr/bin/env sh
pushd ~/projects/dotfiles
sudo nixos-rebuild switch --flake .#laptop --show-trace
popd
