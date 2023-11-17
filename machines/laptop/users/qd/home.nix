{ laptop, nix-doom-emacs, smos, ... }:
with laptop; {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    git = import ./../git.nix;
    vim = import ./../vim.nix;
    smos.enable = true;
    vscode = import ./packages/codium.nix { inherit pkgs; };
  };
  imports = [
    nix-doom-emacs.hmModule
    ./../../../../modules/hm/emacs
    smos.homeManagerModules.${system}.default
    ./../../../../modules/hm/gaming
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
