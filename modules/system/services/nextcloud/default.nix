{ config, lib, pkgs, ... }:

{
  imports = [ ./nextcloud.nix ./nginx.nix ./db.nix ];
  systemd.services."nextcloud-setup" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };

}
