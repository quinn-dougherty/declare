{ pinephone, mobile-nixos }:

with pinephone;

(import "${mobile-nixos}/lib/configuration.nix" {
  device = "pine64-pinephone";
}) // {

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    interfaces.wlp170s0.useDHCP = true;
  };

  time.timeZone = timezone;
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  users = {
    mutableUsers = false;
    users.${username} = let keys-path = ./../../common/keys;
    in {
      isNormalUser = true;
      description = user-fullname;
      home = "/home/" + username;
      # uid = 1000;
      # make this numeric so that you can enter it in the phosh lockscreen.
      # DON'T leave this empty: not all greeters support passwordless users.
      initialPassword = "999999";
      extraGroups = [ "wheel" "networkmanager" ];
      openssh.authorizedKeys.keyFiles = [ "${keys-path}/authorized_keys" ];
    };
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  nixpkgs.config = config;

  system.stateVersion = "23.11";
}
