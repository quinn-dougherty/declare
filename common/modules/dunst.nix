{ config, lib, pkgs, ... }:

{
  systemd.user.services.dunst = {
    enable = true;
    description = "Dunst <notifications>";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Restart = "always";
      RestartSec = 2;
      ExecStart = "${pkgs.dunst}/bin/dunst";
    };
  };
}
