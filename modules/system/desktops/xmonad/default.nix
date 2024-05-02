{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.xserver = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = builtins.readFile ./xmonad.hs;
      enableConfiguredRecompile = true;
    };
    # Configure keymap in X11
    layout = "us";
    xkbVariant = "";

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
  };
  imports = [
    ./../greeter.nix
    ./../common-none.nix
    ./../intel-graphics.nix
  ];
  sound.mediaKeys.enable = true;
  programs.evince.enable = true;
}
