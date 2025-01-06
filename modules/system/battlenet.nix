{
  inputs,
  laptop,
  config,
  lib,
  pkgs,
  ...
}:
let
  wowup-url = "https://github.com/WowUp/WowUp.CF/releases/download/v2.20.0/WowUp-CF-2.20.0.AppImage";
  wowup = pkgs.appimageTools.wrapType2 {
    pname = "wowup";
    version = "2.20.0";
    src = pkgs.fetchurl {
      url = wowup-url;
      sha256 = "sha256-Fu0FqeWJip0cXSifu1QDktu73SsxGpkEU3cuYbFghxc=";
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
