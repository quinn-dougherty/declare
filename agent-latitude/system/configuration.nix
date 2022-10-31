# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ agent, ... }:

{
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
    gc = {
      automatic = true;
      dates = "weekly";
    };
    settings.auto-optimise-store = true;
  };

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot/efi";
  };

  networking = {
    hostName = agent.hostname; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager.enable = true;
    # Open ports in the firewall.
    firewall.allowedTCPPorts = [ 443 ]; # For herc
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

  };
  # Set your time zone.
  time.timeZone = agent.timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;

      # Enable the GNOME Desktop Environment.
      desktopManager.gnome.enable = true;
      displayManager = {
        gdm.enable = true;

        # Enable automatic login for the user.
        autoLogin = {
          enable = true;
          user = agent.username;
        };
      };

      # Gnome has touchpad support by default, so we skip this.
      # libinput.enable = true;

      # Configure keymap in X11
      layout = "us";
      xkbVariant = "";
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      # require public key authentication for better security
      passwordAuthentication = false;
      kbdInteractiveAuthentication = false;
    };
    avahi.enable = true;
    hercules-ci-agent = {
      enable = true;
      settings.concurrentTasks = "auto";
    };

  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    ${agent.username} = {
      isNormalUser = true;
      description = agent.user-fullname;
      extraGroups = [ "networkmanager" "wheel" ];
      openssh.authorizedKeys.keyFiles = [ ./../../common/keys/authorized_keys ];
    };
    root.openssh.authorizedKeys.keyFiles =
      [ ./../../common/keys/authorized_keys ];
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };
  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = builtins.concatLists [
    (import ./../../common/packages/utils.nix { pkgs = agent.pkgs; })
    (import ./../../common/packages/devops.nix { pkgs = agent.pkgs; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
