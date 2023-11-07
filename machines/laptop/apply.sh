#!/usr/bin/env sh
pushd ~/projects/declare
sudo nixos-rebuild switch --flake .#grindenstern --show-trace
popd
