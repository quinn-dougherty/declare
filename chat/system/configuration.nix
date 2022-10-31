{ chat }:

{
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

  networking.hostName = chat.hostname;

  time.timeZone = chat.timezone;
  i18n.defaultLocale = "en_US.utf8";

  users.users = {
    ${chat.username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      openssh.authorizedKeys.keyFiles = [ ./../../common/keys/authorized_keys ];
    };
    root.openssh.authorizedKeys.keyFiles =
      [ ./../../common/keys/authorized_keys ];
  };

}
