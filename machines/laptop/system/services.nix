{ pkgs }:
{
  thermald.enable = true;

  logind.lidSwitch = "hibernate";

  fwupd.enable = true;

  printing.enable = true;
  avahi = {
    nssmdns4 = true;
    openFirewall = true;
  };
}
