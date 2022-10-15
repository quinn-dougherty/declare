{ config, pkgs, ... }:

{
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    vscode = import ./packages/codium.nix { inherit pkgs; };
    fish.enable = true;

    # let home-manager install and update itself
    home-manager.enable = true;
  };

#  xsession = {
#    enable = true;
#  };

  home = {
    packages = let
      ops = import ./packages/ops.nix { inherit pkgs; };
      chat = import ./packages/chat.nix { inherit pkgs; };
      desktop = import ./packages/x.nix { inherit pkgs; };
      utils = import ./packages/utils.nix { inherit pkgs; };
      gaming = import ./packages/gaming.nix { inherit pkgs; };
    in builtins.concatLists [
      ops
      chat
      desktop
      utils
      gaming
      # [ daedalus ] # .outputs.${pkgs.system}.daedalus.packages.default ]
    ];
    username = "qd";
    homeDirectory = "/home/qd";

    # You can update home-manager without changing this value
    stateVersion = "20.09";
  };
}
