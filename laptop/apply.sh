#!/usr/bin/env sh
pushd ~/projects/declare
sudo nixos-rebuild switch --flake .#laptop --show-trace
popd
