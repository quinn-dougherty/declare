{ config, lib, pkgs, ... }:

{
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.slick = {
      enable = true;
      theme.name = "Adwaita-dark";
      font.name = "Monospace";
    };
  };
}
