{ doom, inputs, config, lib, pkgs, ... }: {
  environment.systemPackages = [ doom pkgs.mesa ];
  imports = [
    ./../greeter.nix
    ./../common-none.nix
    ./../picom.nix
    # ./../intel-graphics.nix
  ];
  services.xserver = {
    enable = true;
    windowManager.session = lib.singleton {
      name = "DOOM";
      start = ''
        ${builtins.readFile ./xinitrc}
        ${doom}/bin/emacs
      '';
    };
  };
}
