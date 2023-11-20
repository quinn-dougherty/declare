{ config, lib, pkgs, ... }:

{
  imports = [ ./../secrets ./nextcloud.nix ./nginx.nix ./db.nix ];
  systemd.services."nextcloud-setup" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };

}
