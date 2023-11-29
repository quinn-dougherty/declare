{ inputs, config, lib, pkgs, ... }:
let
  doom = import "${inputs.self}/modules/emacs" { inherit inputs pkgs; };
  loadScript = pkgs.writeText "load-exwm.el" ''
    (require 'exwm-systemtray)
    (require 'exwm-randr)
    (exwm-systemtray-enable)
    (exwm-randr-enable)
    (exwm-enable)
  '';
in {
  imports = [ ./../greeter.nix ./../common-none.nix ]; # ./../picom.nix ];
  services.xserver = {
    enable = true;
    windowManager.session = lib.singleton {
      name = "exwm";
      start = "${doom}/bin/emacs"; # -l ${loadScript}";
    };
  };
}
