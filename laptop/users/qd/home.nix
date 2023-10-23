{ laptop, nix-doom-emacs, smos, ... }:
with laptop; {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    vscode = import ./packages/codium.nix { inherit pkgs; };
    doom-emacs = let doomDir = ./doom.d;
    in with pkgs;
    import ./packages/emacs.nix { inherit doomDir linkFarm emptyFile; };

    # let home-manager install and update itself
    home-manager.enable = true;
  };

  imports =
    [ nix-doom-emacs.hmModule smos.homeManagerModules.${system}.default ];
  # services.dropbox.enable = true;
  home = {
    packages = import ./packages { inherit pkgs; };
    username = username;
    homeDirectory = "/home/" + username;

    # You can update home-manager without changing this value
    stateVersion = "20.09";
  };
}
