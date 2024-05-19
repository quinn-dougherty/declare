{
  laptop,
  config,
  lib,
  pkgs,
  ...
}:

{
  services.flatpak.enable = true;
  xdg.portal =
    if
      builtins.elem laptop.desktop [
        "exwm"
        "xmonad"
      ]
    then
      {
        enable = true; # Needed for flatpak
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        config.common.default = "*";
        lxqt.enable = true;
      }
    else
      { };
}
