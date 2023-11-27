{ config, lib, pkgs, ... }: {
  # imports = [ ./../picom.nix ];
  environment.systemPackages = with pkgs; [
    arandr
    dmenu
    haskellPackages.xmobar
    xcompmgr # removal is possible performance boost?
    xorg.xbacklight
    feh
    flameshot
    xscreensaver
    xclip
    dunst # systemd configured in homemanager, but this for on the fly cli

    trayer
    # keyboard
    warpd
  ];
}
