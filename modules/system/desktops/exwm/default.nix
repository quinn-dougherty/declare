{ doom, inputs, config, lib, pkgs, ... }: {
  environment.systemPackages = [ doom ];
  imports = [
    ./../greeter.nix
    ./../common-none.nix
    ./../picom.nix
    ./../intel-graphics.nix
  ];
  services.xserver = {
    enable = true;
    windowManager.session = lib.singleton {
      name = "exwm";
      start = "${doom}/bin/emacs";
    };
  };
}
