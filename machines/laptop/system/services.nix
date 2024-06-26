{ pkgs }:
{
  upower = {
    enable = true;
    percentageLow = 30;
    percentageCritical = 11;
    percentageAction = 5;
  };

  thermald.enable = true;

  logind.lidSwitch = "hibernate";

  autorandr.enable = true;

  urxvtd.enable = true;

  fwupd.enable = true;

  # Enable CUPS to print documents.
  printing.enable = true;
}
