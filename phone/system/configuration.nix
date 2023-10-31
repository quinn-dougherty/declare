{ phone }:
with phone; {
  networking = {
    hostName = hostname;
    networkmanager = {
      enable = true;
      unmanaged = [ "rndis0" "usb0" ];
    };
    interfaces.wlan0.useDHCP = true;
  };
  hardware = {
    sensor.iio.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
    };
  };
  powerManagement.enable = true;

  zramSwap.enable = true;

  time.timeZone = timezone;
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";
  services.xserver.displayManager.autoLogin.user = username;
  users = {
    mutableUsers = false;
    users.${username} =
      let keys-path = ./../../common/keys;
      in {
        isNormalUser = true;
        description = user-fullname;
        home = "/home/" + username;
        shell = pkgs.fish;
        uid = 1000;
        # make this numeric so that you can enter it in the phosh lockscreen.
        # DON'T leave this empty: not all greeters support passwordless users.
        initialPassword = "9999";
        extraGroups = [ "wheel" "networkmanager" "dialout" "feedbackd" "video" ];
        openssh.authorizedKeys.keyFiles = [ "${keys-path}/authorized_keys" ];
      };
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  nixpkgs.config = config;

  programs = {
    fish.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
  system.stateVersion = "23.11";
}
