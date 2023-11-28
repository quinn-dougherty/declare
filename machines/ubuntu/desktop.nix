{ config, lib, pkgs, ... }:

{
  xdg.desktopEntries = {
    firefox = {
      name = "Firefox";
      genericName = "Web Browser";
      exec = "firefox %U";
      terminal = false;
      categories = [ "Application" "Network" "WebBrowser" ];
      mimeType = [ "text/html" "text/xml" ];
    };
    bitwarden = {
      name = "Bitwarden";
      genericName = "Password Manager";
      exec = "bitwarden %U";
      terminal = false;
      categories = [ "Application" ];
      mimeType = [ ];
    };
  };
}
