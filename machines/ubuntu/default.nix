{ lib, ubuntu, home-manager, nix-doom-emacs }:

{
  inherit (ubuntu) system username hostname drv-name-prefix;
  homemanager = import ./home.nix { inherit ubuntu home-manager; };
  homeshell = { };
}
