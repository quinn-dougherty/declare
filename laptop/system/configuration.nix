{ laptop, ... }:
with laptop; {
  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl = { "fs.inotify.max_user_watches" = 524288; };
    # trying to improve lid close situation: https://github.com/NixOS/nixos-hardware/pull/717
    # kernelParames = [ "mem_sleep_default=deep" ];
  };

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    interfaces.wlp170s0.useDHCP = true;
  };

  virtualisation.docker.enable = true;

  time.timeZone = timezone;

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  services = import ./services { inherit pkgs; };

  users.users =
    let keys-path = ./../../common/keys;
    in {
      ${username} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "docker" "video" ];
        home = "/home/" + username;
        description = user-fullname;
        shell = pkgs.fish;
        openssh.authorizedKeys.keyFiles = [ "${keys-path}/authorized_keys" ];
      };
      root = {
        openssh.authorizedKeys.keyFiles = [ "${keys-path}/authorized_keys" ];
        shell = pkgs.fish;
      };
    };

  environment = {
    variables = {
      EDITOR = "emacs";
      VISUAL = "emacs";
    };
    etc."xdg/user-dirs.defaults".text = ''
      DESKTOP=desktop
      DOWNLOAD=downloads
      TEMPLATES=pdf
      PUBLICSHARE=documents
      PICTURES=screenshots
      DOCUMENTS=projects
      MUSIC=org
      VIDEOS=games
    '';
  };
  nixpkgs.config = config;

  programs = {
    steam.enable = true;
    fish.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    thunar.enable = true;
    slock.enable = true;
  };
  hardware.opengl.driSupport32Bit = true; # helps with lutris?

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
