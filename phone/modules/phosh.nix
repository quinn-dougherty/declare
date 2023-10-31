{ pinephone }: {
  services.xserver.desktopManager.phosh = {
    enable = true;
    user = pinephone.username;
    # group = "users";
  };
}
