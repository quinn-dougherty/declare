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
      openssh.authorizedKeys.keyFiles = [
        ./../../common/secrets/id_ed25519.pub
        ./../../common/secrets/id_rsa.pub
        ./../../common/secrets/herc-default-id_rsa.pub
      ];
    };
    root.openssh.authorizedKeys.keyFiles =
      [ ./../../common/secrets/herc-default-id_rsa.pub ];
  };

  environment.variables = {
    EDITOR = "emacs";
    VISUAL = "emacs";
  };
  nixpkgs.config = config;

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

