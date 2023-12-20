{ inputs, config, lib, pkgs, ... }:

{
  imports = [
    "${inputs.self}/modules/system/emacs"
    ./../greeter.nix
    ./../common-none.nix
    ./../picom.nix
    ./../intel-graphics.nix
  ];
  editors.emacs = {
    enable = true;
    doom.enable = true;
  };
  services.xserver = {
    windowManager.exwm = {
      enable = true;
      enableDefaultConfig = true;
      extraPackages = epkgs: with epkgs; [ magit evil vterm ];
    };
    enable = true;
  };
}
