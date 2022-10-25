#!/usr/bin/env sh
pushd ~/Dropbox/dotfiles
nix run .#apps.nixinate.herc-agent
popd
