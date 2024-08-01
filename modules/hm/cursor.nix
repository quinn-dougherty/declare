{ pkgs, ... }:

let
  url = "https://downloader.cursor.sh/linux/appImage/x64";
  sha256 = "sha256-Qcph6UYR+VtlaYNqHJpIGEVHu1q8Vbfvm5Bv6swf+pM=";
  cursor = pkgs.appimageTools.wrapType2 {
    name = "cursor";
    version = "0.35.0";
    src = pkgs.fetchurl {
      inherit url sha256;
    };
  };
in
{
  home.packages = [ cursor ];
}
