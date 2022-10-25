# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ framework, ... }:
with framework; {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../common/cachix.nix
  ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      # options = "--delete-older-than 60d";
    };
  };

  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest; # for wifi support
    kernel.sysctl = { "fs.inotify.max_user_watches" = 524288; };
  };

  networking = import ./networking.nix { inherit hostname; };

  virtualisation.docker.enable = true;

  # Set your time zone.
  time.timeZone = timezone;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  services = import ./services { inherit pkgs; };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    ${username} = {
      isNormalUser = true;
      extraGroups =
        [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
      home = "/home/" + username;
      description = "Quinn Dougherty";
      shell = pkgs.fish;
    };
    root.openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCyJAP5TohEIOSV2uuz4XE0B8x55LLQUlXgRad84hAN01Az5U0xWfZhyCrQO+3rhZ6YgBwbpZrMc7+Pyb4z6BHE2i4e7omSIATFMt7eSFuOaRYiXUEKX56AFlWiU1NcLNVKnFCnhAHKh/eDGBtRR6C0oA2DoMj8OOhYwgYOT4c+Y7IDOtlC+RmwRUhRlhrchz3Z1zg9Z4aln75dreq30xtBU+wfLdsvOUiVqtkMwiCfzvbF/DoVWqAzsciXhGvMR5B69l0CZU3lMDnqZ/VYVEYgcILC9ME5l6FhYTHwoToi0QTu+BIFFej3PCS/puLta/vzCvlT+J4jCnLMQW4qkVzEbZ3eQJ1Yf8HH1elHj+aT1RjWg80DTJhZAG+LpITEizEE3PIwg+85aY14zuxox7gHzBbNRzrdW7wWT1KTT7xfwNpS2AM8eJWzDypjSJRa9oj9wR9MT7lnyYor4B/fx5RB9Ch7so1uICfhGACmfrvriv0KaSm4YPHuarAp6WL5uRE= default-ssh@hercules-ci"
    ];
  };

  environment.variables = {
    EDITOR = "emacs";
    VISUAL = "emacs";
  };
  nixpkgs.config.allowUnfree = true;

  programs = {
    steam.enable = true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  systemd.user.services = {
    dropbox = {
      description = "Dropbox <cloud backup>";
      after = [ "xembedsniproxy.service" ];
      wants = [ "xembedsniproxy.service" ];
      wantedBy = [ "graphical-session.target" ];
      environment = {
        QT_PLUGIN_PATH = "/run/current-system/sw/"
          + pkgs.qt5.qtbase.qtPluginPrefix;
        QML2_IMPORT_PATH = "/run/current-system/sw/"
          + pkgs.qt5.qtbase.qtQmlPrefix;
      };
      serviceConfig = {
        ExecStart = "${pkgs.dropbox.out}/bin/dropbox";
        ExecReload = "${pkgs.coreutils.out}/bin/kill -HUP $MAINPID";
        KillMode = "control-group";
        Restart = "on-failure";
        PrivateTmp = true;
        ProtectSystem = "full";
        Nice = 10;
      };
    };

    dunst = {
      enable = true;
      description = "Dunst <notifications>";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        Restart = "always";
        RestartSec = 2;
        ExecStart = "${pkgs.dunst}/bin/dunst";
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

