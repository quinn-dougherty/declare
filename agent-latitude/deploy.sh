#!/usr/bin/env sh

# Note: CI deploys the agent on every push to `main` branch, so you should never really need to do this.

pushd ~/Dropbox/dotfiles
nix run .#apps.nixinate.herc-agent-latitude
popd
