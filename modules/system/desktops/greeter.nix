{ config, lib, pkgs, ... }:

{
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.gtk = {
      enable = true;
      theme.name = "Adwaita-dark";
    };
  };
}
