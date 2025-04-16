# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  inputs,
  machine,
  config,
  ...
}:
let
  server = machine;
  keyspath = "${inputs.self}/keys";
in
{
  # nixpkgs.pkgs = server.pkgs;
  # nixpkgs.config = config;
  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = server.hostname;
    networkmanager.enable = true;
    # wireless = {
    #   enable = true;
    #   networks."Andromeda".pskRaw = "";
    # };
    interfaces.wlp170s0.useDHCP = true;
    # interfaces.wlp170s0.ipv4.addresses = [{
    #  address = server.static4;
    #  prefixLength = 24;
    # }];
  };
  time.timeZone = server.timezone;
  virtualisation.docker.enable = true;

  services = {
    logrotate.enable = true;
    fwupd = {
      enable = true;
      uefiCapsuleSettings.DisableCapsuleUpdateOnDisk = true;
    };
    printing.enable = true;
    getty.autologinUser = server.username;
  };

  secrix.defaultEncryptKeys.${server.username} = [
    (builtins.readFile "${keyspath}/id_server_ed25519.pub")
    (builtins.readFile "${keyspath}/id_qd_ed25519.pub")
  ];
  users.users =
    let
      authorizedKeyFiles = [
        "${keyspath}/id_qd_ed25519.pub"
        "${keyspath}/id_ed25519.pub"
        "${keyspath}/id_server_ed25519.pub"
        "${keyspath}/id_server_rsa_effectsdefault.pub"
      ];
    in
    {
      ${server.username} = {
        isNormalUser = true;
        description = server.user-fullname;
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
        ];
        openssh.authorizedKeys.keyFiles = authorizedKeyFiles;
        # shell = server.pkgs.fish;
      };
      root.openssh.authorizedKeys.keyFiles = authorizedKeyFiles;
    };

  programs = {
    # fish.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    git = {
      enable = true;
      lfs.enable = true;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
