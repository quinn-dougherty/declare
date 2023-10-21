# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ server, ... }:

{
  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  networking = {
    hostName = server.hostname;
    networkmanager.enable = true;
    interfaces.wlp3s0.ipv4.addresses = [{
      address = server.static4;
      prefixLength = 24;
    }];
  };
  time.timeZone = server.timezone;

  i18n.defaultLocale = "en_US.utf8";

  services = {
    xserver.displayManager.autoLogin = {
      enable = true;
      user = server.username;
    };
    fwupd.enable = true;

    printing.enable = true;
  };

  users.users = {
    ${server.username} = {
      isNormalUser = true;
      description = server.user-fullname;
      extraGroups = [ "networkmanager" "wheel" ];
      openssh.authorizedKeys.keyFiles = [ ./../../common/keys/authorized_keys ];
    };
    root.openssh.authorizedKeys.keyFiles =
      [ ./../../common/keys/authorized_keys ];
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
