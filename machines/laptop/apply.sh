#!/usr/bin/env sh
pushd /home/qd/Projects/declare
sudo nixos-rebuild switch --flake .#rise --show-trace --option eval-cache false
popd

pushd /home/qd/.config/emacs
./bin/doom sync -u
popd
