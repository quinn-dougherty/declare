{ framework, nix-doom-emacs, ... }:
with framework; {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    vscode = import ./packages/codium.nix { inherit pkgs; };
    steam.enable = true;
    fish.enable = true;

    doom-emacs = {
      enable = true;
      doomPrivateDir = ./doom.d;
    };

    # let home-manager install and update itself
    home-manager.enable = true;
  };

  imports = [ nix-doom-emacs.hmModule ];
  home = {
    packages = import ./packages { inherit pkgs; };
    username = username;
    homeDirectory = "/home/" + username;

    # You can update home-manager without changing this value
    stateVersion = "20.09";
  };
}
