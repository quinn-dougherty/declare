{ lib, ubuntu, home-manager }:

{
  inherit (ubuntu) system username hostname drv-name-prefix;
  homemanager = import ./home.nix { inherit ubuntu home-manager; };
  homeshell = { };
}
