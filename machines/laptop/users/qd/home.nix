{ laptop, nix-doom-emacs, smos, ... }:
with laptop; let modpath = ./../../../../modules/hm; in {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    smos.enable = true;
    # vscode = import ./packages/codium.nix { inherit pkgs; };
  };
  imports = [
    nix-doom-emacs.hmModule
    "${modpath}/emacs"
    "${modpath}/git.nix"
    "${modpath}/vim.nix"
    "${modpath}/codium.nix"
    smos.homeManagerModules.${system}.default
  ];
  home = {
    packages = import ./packages { inherit pkgs; };
    username = username;
    homeDirectory = "/home/" + username;

    # You can update home-manager without changing this value
    stateVersion = "20.09";
  };
  services = if desktop == "xmonad" then import ./xservices.nix else { };
}
