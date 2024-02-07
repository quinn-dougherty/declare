#!/usr/bin/env sh
pushd /home/qd/projects/declare
sudo nixos-rebuild switch --flake .#grindenstern --show-trace --option eval-cache false
popd

pushd /home/qd/.config/emacs
./bin/doom install
./bin/doom sync -u
popd
