{ pkgs, ... }:

let
  cursor-url = "https://downloader.cursor.sh/linux/appImage/x64";
  cursor = pkgs.appimageTools.wrapType2 {
    name = "cursor";
    version = "0.35.0";
    src = pkgs.fetchurl {
      url = cursor-url;
      sha256 = "sha256-Fsy9OVP4vryLHNtcPJf0vQvCuu4NEPDTN2rgXO3Znwo=";
    };
  };
in
{
  home.packages = [ cursor ];
}
