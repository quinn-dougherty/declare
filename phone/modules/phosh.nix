{ pinephone }: {
  services.xserver.desktopManager.phosh = {
    enable = true;
    user = pinephone.username;
    group = "users";
  };

  environment.variables = {
    # Qt apps won't always start unless this env var is set
    QT_QPA_PLATFORM = "wayland";
  };
}
