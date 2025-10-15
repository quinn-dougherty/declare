{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ./../xwayland.nix ./../audio.nix ];
  services = {
    xserver.enable = true;
    desktopManager.plasma6.enable = true;
    displayManager = {
      sddm.enable = true;
      defaultSession = "plasma";
    };
  };
  programs = {
    dconf.enable = true;
    kdeconnect.enable = true;
  };
  xdg.portal.extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
  qt.platformTheme = "kde";
  environment = {
    systemPackages = with pkgs.libsForQt5; [
      qtgraphicaleffects
      kio
      # kio-admin
      # pkgs.kup
    ];
    sessionVariables.SSH_ASKPASS_REQUIRE = "prefer";
  };
}
