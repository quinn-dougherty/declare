#!/usr/bin/env sh
pushd ~/Projects/dotfiles
sudo nixos-rebuild switch --flake .#laptop --show-trace
popd
