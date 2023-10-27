# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ server, ... }:

{
  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = server.hostname;
    networkmanager.enable = true;
    interfaces.wlp170s0.ipv4.addresses = [{
      address = server.static4;
      prefixLength = 24;
    }];
  };
  time.timeZone = server.timezone;

  services = {
    fwupd.enable = true;
    printing.enable = true;
  };

  users.users = {
    ${server.username} = {
      isNormalUser = true;
      description = server.user-fullname;
      extraGroups = [ "networkmanager" "wheel" ];
      openssh.authorizedKeys.keyFiles = [ ./../../common/keys/authorized_keys ];
      shell = server.pkgs.fish;
    };
    root.openssh.authorizedKeys.keyFiles =
      [ ./../../common/keys/authorized_keys ];
  };

  programs = {
    fish.enable = true;
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
  system.stateVersion = "23.05"; # Did you read the comment?
}
