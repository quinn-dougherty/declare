{ pkgs }: {
  fprintd.enable = true; # for fingerprint support

  upower = {
    enable = true;
    percentageLow = 30;
    percentageCritical = 11;
    percentageAction = 5;
  };

  clipcat.enable = true;

  xserver = {

    # Enable the X11 windowing system.
    enable = true;
    # Enable xmonad
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = builtins.readFile ./x/xmonad.hs;
      enableConfiguredRecompile = true;
    };
    # Configure keymap in X11
    layout = "us";

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
  };

  fwupd.enable = true;

  # Enable CUPS to print documents.
  printing.enable = true;

  tailscale.enable = false;
  mullvad-vpn.enable = false;

  postgresql = {
    enable = true;
    package = pkgs.postgresql_14;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE USER "guesstimate-api" WITH PASSWORD 'password';
      ALTER USER "guesstimate-api" CREATEDB;
    '';
  };

  # Enable the OpenSSH daemon.
  openssh.enable = true;

  elasticsearch = {
    package = pkgs.elasticsearch7;
    enable = true;
  };
}
