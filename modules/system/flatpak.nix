{ laptop, config, lib, pkgs, ... }:

{
  services.flatpak.enable = true;
  environment.systemPackages = [ pkgs.winetricks ];
  xdg.portal =
    if laptop.desktop == "xmonad" then {
      enable = true; # Needed for flatpak
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = "*";
    } else { };
}
