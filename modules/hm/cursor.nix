{ pkgs, ... }:

let
  version = "1.1.6";
  url = "https://downloads.cursor.com/production/5b19bac7a947f54e4caa3eb7e4c5fbf832389853/linux/x64/Cursor-1.1.6-x86_64.AppImage";
  sha256 = "sha256-T0vJRs14tTfT2kqnrQWPFXVCIcULPIud1JEfzjqcEIM=";
  cursor = pkgs.appimageTools.wrapType2 {
    inherit version;
    pname = "cursor";
    src = pkgs.fetchurl { inherit url sha256; };
  };
in
{
  home.packages = [ cursor ];
}
