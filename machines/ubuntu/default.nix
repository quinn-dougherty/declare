{ lib, inputs, ubuntu }:

{
  inherit (ubuntu) system username hostname drv-name-prefix;
  homemanager = import ./home.nix {
    inherit ubuntu;
    inherit (inputs) home-manager;
  };
  homeshell = { };
}
