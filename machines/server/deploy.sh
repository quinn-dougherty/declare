#!/usr/bin/env sh

# Note: CI deploys the agent on every push to `main` branch, so you should never really need to do this.

pushd ~/projects/declare
nixos-rebuild --build-host admin@192.168.42.42 --flake .#server
popd
