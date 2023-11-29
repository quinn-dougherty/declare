{ lib, ubuntu, home-manager, nix-doom-emacs }:

with ubuntu; {
  inherit (ubuntu) system hostname drv-name-prefix;
  homemanager = import ./home.nix { inherit ubuntu home-manager; };
  homeshell = { };
}
