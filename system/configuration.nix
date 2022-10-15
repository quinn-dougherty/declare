# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./cachix.nix
  ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      auto-optimise-store = true;
      substituters = [
        "https://iohk.cachix.org"
        "https://hydra.iohk.io"
        # "ssh://nix-ssh@ci.ardana.platonic.systems"
        "https://quantified-uncertainty.cachix.org"
        "https://effective-altruism.cachix.org"
      ];
      trusted-public-keys = [
        "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
        # "ci.ardana.platonic.systems:yByqhxfJ9KIUOyiCe3FYhV7GMysJSA3i5JRvgPuySsI=
        "quantified-uncertainty.cachix.org-1:6Dmk4ZKzEPai4o0FovuUyeZ0lZcf3/4v+MTHWaxczzc="
        "effective-altruism.cachix.org-1:mybF0dFfu2Bxbc+LuNm7rb46MFY4FGG2GhwdHuQPWxU="
      ];

    };
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

  networking = {
    hostName = "fw"; # Define your hostname.
    wireless = {
      enable = true; # Enables wireless support via wpa_supplicant.
      userControlled.enable = true; # Enables wpa_supplicant gui
      allowAuxiliaryImperativeNetworks = true;
    };

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.wlp170s0.useDHCP = true;
    # interfaces.tailscale0.useDHCP = true;

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # 17500 is for dropbox, 443 is for herc
    firewall.allowedTCPPorts = [ 17500 443 ];
    firewall.allowedUDPPorts = [ 17500 443 ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };

  virtualisation.docker.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  services = {
    fprintd.enable = true; # for fingerprint support

    upower = {
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
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.qd = {
    isNormalUser = true;
    extraGroups =
      [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
    home = "/home/qd";
    description = "Quinn Dougherty";
    shell = pkgs.fish;
  };

  environment = {
    variables = {
      EDITOR = "emacs";
      VISUAL = "emacs";
    };
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      dropbox-cli

      # Gaming  # This can't be in home-manager because login.
      factorio

      wpa_supplicant_gui
    ];
  };
  nixpkgs.config = {
    st.conf = builtins.readFile ./st-config.h;
    packageOverrides = pkgs: {
      factorio = pkgs.factorio.override {
        username = "quinnd";
        token = import ./secrets/factorio-secret.nix;
      };
    };
    allowUnfree = true;
  };

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

