{ lib, ubuntu, home-manager, nix-doom-emacs }:

with ubuntu; {
  inherit (ubuntu) system username hostname drv-name-prefix;
  homemanager = import ./home.nix { inherit ubuntu home-manager; };
  homeshell = { };
}
