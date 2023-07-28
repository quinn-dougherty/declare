{ config, lib, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud27;
    hostName = "localhost";
    config.adminpassFile = "${pkgs.writeText "adminpass" "test123"}";
    # extraApps = with config.services.nextcloud.package.packages.apps; {
    #   inherit notes polls tasks calendar twofactor_webauthn bookmarks;
    # };
    extraAppsEnable = true;
  };
}
