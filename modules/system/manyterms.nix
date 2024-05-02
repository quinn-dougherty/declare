{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # Extra terminals
    st
    libsForQt5.konsole
    xterm
    sakura
    # xfce.xfce4-terminal
  ];
}
