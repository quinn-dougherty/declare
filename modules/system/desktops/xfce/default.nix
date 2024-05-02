{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ./../greeter.nix ];
  services.xserver = {
    enable = true;
    desktopManager.xfce.enable = true;
    displayManager.defaultSession = "xfce";
  };
}
