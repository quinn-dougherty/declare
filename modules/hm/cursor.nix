{ pkgs, ... }:

let
  url = "https://download.todesktop.com/230313mzl4w4u92/cursor-0.44.11-build-250103fqxdt5u9z-x86_64.AppImage";
  sha256 = "sha256-eOZuofnpED9F6wic0S9m933Tb7Gq7cb/v0kRDltvFVg=";
  cursor = pkgs.appimageTools.wrapType2 {
    pname = "cursor";
    version = "0.44.11";
    src = pkgs.fetchurl { inherit url sha256; };
  };
in
{
  home.packages = [ cursor ];
}
