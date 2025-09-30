{ pkgs, ... }:

let
  version = "1.6.27";
  url = "https://downloads.cursor.com/production/d750e54bba5cffada6d7b3d18e5688ba5e944ad9/linux/x64/Cursor-1.6.27-x86_64.AppImage";
  sha256 = "sha256-U+Iw9uXipona52GxUaPm2QxuDyWtmpPa6VJXnjP30C4=";
  cursor = pkgs.appimageTools.wrapType2 {
    inherit version;
    pname = "cursor";
    src = pkgs.fetchurl { inherit url sha256; };
  };
in
{
  home.packages = [ cursor ];
}
