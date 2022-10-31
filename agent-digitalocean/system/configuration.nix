# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ agent }: {
  nix.gc = {
    automatic = true;
    dates = "weekly";
  };

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    version = 2;
    # efiSupport = true;
    # efiInstallAsRemovable = true;
    # Define on which hard drive you want to install Grub.
    device = "nodev"; # "/dev/sda"; # or "nodev" for efi only
  };
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";

  swapDevices = [{
    device = "/var/swapfile";
    size = 4096;
  }];
  fileSystems."/mnt/${agent.volume}" = {
    device = "/dev/disk/by-id/scsi-0DO_Volume_${agent.volume}";
    fsType = "ext4";
    options = [ "discard" "defaults" "noatime" ];
  };

  networking.hostName = agent.hostname;
  time.timeZone = agent.timezone;

  users.users = let keys-path = ./../../common/keys;
  in {
    ${agent.username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      openssh.authorizedKeys.keyFiles = [ "${keys-path}/authorized_keys" ];
    };
    root.openssh.authorizedKeys.keyFiles = [ "${keys-path}/authorized_keys" ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
