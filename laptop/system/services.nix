{ pkgs }: {
  upower = {
    enable = true;
    percentageLow = 30;
    percentageCritical = 11;
    percentageAction = 5;
  };

  autorandr.enable = true;

  urxvtd.enable = true;

  fwupd.enable = true;

  # Enable CUPS to print documents.
  printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };

  elasticsearch = {
    package = pkgs.elasticsearch7;
    enable = false;
  };
}
