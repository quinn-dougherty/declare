{ pkgs }: {
  # 1. I never use this, 2. https://github.com/NixOS/nixpkgs/issues/198038
  # At least give it a week or so for the fix to propagate to `nixos-unstable` pin.
  fprintd.enable = false; # for fingerprint support
  # Also note: this is in the nixos-hardware fw module

  upower = {
    enable = true;
    percentageLow = 30;
    percentageCritical = 11;
    percentageAction = 5;
  };

  clipcat.enable = true;

  autorandr = import ./x/randr;
  xserver = {
    enable = true;
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

  postgresql = import ./guesstimate-postgres.nix { inherit pkgs; };

  openssh.enable = true;
  avahi.enable = true;

  elasticsearch = {
    package = pkgs.elasticsearch7;
    enable = true;
  };
}
