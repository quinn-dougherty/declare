{ pkgs }: {
  upower = {
    enable = true;
    percentageLow = 30;
    percentageCritical = 11;
    percentageAction = 5;
  };

  clipcat.enable = true;

  autorandr = import ./x/randr;
  xserver = import ./x;

  urxvtd.enable = true;

  fwupd.enable = true;

  # Enable CUPS to print documents.
  printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };

  tailscale.enable = false;
  mullvad-vpn.enable = false;

  postgresql = import ./guesstimate-postgres.nix { inherit pkgs; };

  # openssh.enable = true;  # delete if using module import works.

  elasticsearch = {
    package = pkgs.elasticsearch7;
    enable = false;
  };
}
