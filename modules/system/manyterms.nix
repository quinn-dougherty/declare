{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.urxvtd.enable = true;
  environment.systemPackages = with pkgs; [
    # Extra terminals
    st
    # libsForQt5.konsole
    xterm
    sakura
    # xfce.xfce4-terminal
  ];
}
