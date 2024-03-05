{ config, lib, pkgs, ... }:

{
  imports = [ ./../xwayland.nix ];
  services.xserver = {
    enable = true;
    desktopManager.plasma6 = {
      enable = true;
      # useQtScaling = true;
    };
    displayManager = {
      sddm.enable = true;
      defaultSession = "plasma";
    };
  };
  programs = {
    dconf.enable = true;
    kdeconnect.enable = true;
  };
  qt.platformTheme = "kde";
  environment = {
    systemPackages = [ pkgs.libsForQt5.qt5.qtgraphicaleffects ];
    sessionVariables.SSH_ASKPASS_REQUIRE = "prefer";
  };
}
