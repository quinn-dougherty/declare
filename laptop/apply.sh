#!/usr/bin/env sh
pushd ~/ProjectsSync/dotfiles
sudo nixos-rebuild switch --flake .#laptop
popd
