{ inputs, config, lib, pkgs, ... }:

{
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.gtk = {
      enable = true;
      theme.name = "Adwaita-dark";
      iconTheme.name = "Adwaita-dark";
      cursorTheme.name = "Adwaita-dark";
      extraConfig =
        "background = ${inputs.self}/modules/system/desktops/backgrounds/phaesp.jpg";
    };
  };
}
