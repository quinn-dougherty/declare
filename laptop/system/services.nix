{ pkgs }: {
  upower = {
    enable = true;
    percentageLow = 30;
    percentageCritical = 11;
    percentageAction = 5;
  };

  clipcat.enable = true;

  autorandr.enable = true;

  urxvtd.enable = true;

  fwupd.enable = true;

  # Enable CUPS to print documents.
  printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };

  tailscale.enable = false;
  mullvad-vpn.enable = false;

  elasticsearch = {
    package = pkgs.elasticsearch7;
    enable = false;
  };
}
