{ inputs, config, lib, pkgs, ... }:
let doom = import "${inputs.self}/modules/emacs" { inherit inputs pkgs; };
in {
  imports = [ ./../greeter.nix ./../common-none.nix ./../picom.nix ];
  services.xserver = {
    enable = true;
    windowManager.session = lib.singleton {
      name = "exwm";
      start = "${doom}/bin/emacs";
    };
  };
}
