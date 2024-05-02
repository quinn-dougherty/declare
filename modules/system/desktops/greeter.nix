{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

{
  boot.plymouth = {
    enable = true;
    theme = "breeze";
  };
  services.xserver.displayManager = {
    lightdm = {
      enable = true;
      greeters.gtk = {
        enable = true;
        theme.name = "Adwaita-dark";
        iconTheme.name = "Adwaita-dark";
        cursorTheme.name = "Adwaita-dark";
        extraConfig = ''
          background = ${inputs.self}/modules/system/desktops/backgrounds/phaesp.jpg
          show-power = true
        '';
      };
    };
  };
}
