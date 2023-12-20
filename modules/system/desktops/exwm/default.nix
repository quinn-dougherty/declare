{ inputs, laptop, config, lib, pkgs, ... }: {
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
    enable = true;
    windowManager.session = lib.singleton {
      name = "DOOM";
      start = ''
        ${builtins.readFile ./xinitrc}
        ${config.editors.emacs.package}/bin/emacs --fullscreen --init-directory='/home/${laptop.username}/.config/emacs/'
      '';
    };
  };
}
