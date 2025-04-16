{ machine, inputs, ... }:
with machine;
let
  keyspath = "${inputs.self}/keys";
in
{
  nixpkgs = { inherit config; };
  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # kernel.sysctl = { "fs.inotify.max_user_watches" = 524288; };
    # kernelPackages = pkgs.linuxPackages_6_13; # comment out to go with default
    # kernelParams = [ "thunderbolt.chain_limit=1" "pci=realloc" ];
  };

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    interfaces.wlp170s0.useDHCP = true;
  };

  virtualisation = {
    # qemu.guestAgent.enable = true;
    docker.enable = true;
  };

  time.timeZone = timezone;

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  services = import ./services.nix { inherit pkgs; };

  secrix.defaultEncryptKeys.${username} = [
    (builtins.readFile "${keyspath}/id_ed25519.pub")
    (builtins.readFile "${keyspath}/id_qd_ed25519.pub")
  ];
  users.users =
    let
      authorized-key-files = [
        "${keyspath}/id_ed25519.pub"
        "${keyspath}/id_server_ed25519.pub"
        "${keyspath}/id_qd_ed25519.pub"
      ];
    in
    {
      ${username} = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
          "docker"
          "video"
        ];
        home = "/home/" + username;
        description = user-fullname;
        shell = pkgs.fish;
        openssh.authorizedKeys.keyFiles = authorized-key-files;
      };
      root = {
        openssh.authorizedKeys.keyFiles = authorized-key-files;
        shell = pkgs.fish;
      };
    };

  environment.variables =
    let
      emacs = "${pkgs.emacs}/bin/emacs";
    in
    {
      EDITOR = emacs;
      VISUAL = emacs;
    };

  programs = {
    fish.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    singularity.enable = true;
    thunar.enable = builtins.elem desktop [
      "xmonad"
      "exwm"
    ];
    slock.enable = builtins.elem desktop [
      "xmonad"
      "exwm"
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
