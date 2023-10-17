{
  enable = true;
  windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = builtins.readFile ./xmonad.hs;
    enableConfiguredRecompile = true;
  };
  # Configure keymap in X11
  layout = "us";

  # Enable touchpad support (enabled default in most desktopManager).
  libinput.enable = true;
}
