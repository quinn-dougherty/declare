{
  inputs,
  laptop,
  config,
  lib,
  pkgs,
  ...
}:
let
  wowup-url = "https://github.com/WowUp/WowUp.CF/releases/download/v2.12.0/WowUp-CF-2.12.0.AppImage";
  wowup = pkgs.appimageTools.wrapType2 {
    name = "wowup";
    version = "2.12.0";
    src = pkgs.fetchurl {
      url = wowup-url;
      sha256 = "sha256-uWz/EQBX/d1UBfpc9EL4x+UH72kINd6pqFIvJkV16e8=";
    };
  };
in
{
  imports = [ "${inputs.self}/modules/system/services/flatpak.nix" ];
  environment.systemPackages = [
    pkgs.winetricks
    wowup
  ];
}
