{
  config,
  lib,
  pkgs,
  ...
}:

{
  # https://community.frame.work/t/framework-nixos-linux-users-self-help/31426/77?u=quinn_dougherty
  hardware.wirelessRegulatoryDatabase = true;
  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom="US"
  '';
}
