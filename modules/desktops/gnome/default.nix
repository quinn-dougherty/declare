{ config, lib, pkgs, ... }:

{
  # imports = [ ./../greeter.nix ];
  services = {
    # picom = {
    #   enable = true;
    #   vSync = true;
    #   inactiveOpacity = 0.73;
    # };
    xserver = {
      enable = true;

      # Enable the GNOME Desktop Environment.
      desktopManager.gnome.enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = false;
      };
      deviceSection = ''
        Option "DRI" "2"
        Option "TearFree" "true"
      '';
      # videoDrivers = [ "intel" "modesetting" ];

      # Gnome has touchpad support by default, so we skip this.
      # libinput.enable = true;

      # Configure keymap in X11
      layout = "us";
      xkbVariant = "";
    };
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };
  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };
  environment.systemPackages = with pkgs.gnomeExtensions; [
    appindicator
    vertical-workspaces
    workspace-matrix
    system-monitor
  ];
  programs = {
    evince.enable = true;
    gnome-terminal.enable = true;
  };
}
