{ inputs, config, lib, pkgs, ... }:

{
  imports = [ "${inputs.self}/secrets" ./db.nix ];
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud27; # follow migration instructions online
    hostName = "127.0.0.1"; # "sync.quinn-dougherty.com";

    # Let NixOS install and configure Redis caching automatically.
    configureRedis = true;

    # Increase the maximum file upload size to avoid problems uploading videos.
    maxUploadSize = "16G";
    https = true;

    autoUpdateApps.enable = true;
    extraAppsEnable = true;
    # extraApps = with config.services.nextcloud.package.packages.apps; {
    #   inherit notes polls tasks calendar twofactor_webauthn bookmarks;
    # };
    config = {
      # Further forces Nextcloud to use HTTPS
      overwriteProtocol = "https";

      # Nextcloud PostegreSQL database configuration, recommended over using SQLite
      dbtype = "pgsql";
      dbuser = "nextcloud";
      # dbhost = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
      dbname = "nextcloud";
      dbpassFile = "${pkgs.writeText "adminpass"
        "test123"}"; # "/run/nextcloud-keys/nextcloud-db-pass";

      adminpassFile = "${pkgs.writeText "adminpass"
        "test123"}"; # "/var/nextcloud-admin-pass";
      adminuser = "admin";
    };
  };
}