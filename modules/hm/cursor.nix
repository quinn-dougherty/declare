{ pkgs, ... }:

let
  cursor-url = "https://downloader.cursor.sh/linux/appImage/x64";
  cursor = pkgs.appimageTools.wrapType2 {
    name = "cursor";
    version = "0.35.0";
    src = pkgs.fetchurl {
      url = cursor-url;
      sha256 = "sha256-Wo0mHeOQRo3WxAOXb2OT7h01eZv7dbAyGi6XNsCVtbg=";
    };
  };
in
{
  home.packages = [ cursor ];
}
