{ framework, ... }:
with framework; {
  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # kernelPackages = pkgs.linuxPackages_latest; # This was needed for wifi back in 21.11, but I don't think it is anymore.
    kernel.sysctl = { "fs.inotify.max_user_watches" = 524288; };
  };

  networking = import ./networking.nix { inherit hostname; };

  virtualisation.docker.enable = true;

  time.timeZone = timezone;
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  services = import ./services { inherit pkgs; };

  users.users = let keys-path = ./../../common/keys;
  in {
    ${username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "docker" ];
      home = "/home/" + username;
      description = user-fullname;
      shell = pkgs.fish;
      openssh.authorizedKeys.keyFiles = [ "${keys-path}/authorized_keys" ];
    };
    root.openssh.authorizedKeys.keyFiles = [ "${keys-path}/authorized_keys" ];
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

  systemd.user.services.dunst = {
    enable = true;
    description = "Dunst <notifications>";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Restart = "always";
      RestartSec = 2;
      ExecStart = "${pkgs.dunst}/bin/dunst";
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

