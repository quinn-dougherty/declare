{ pkgs }:

let
  utils = import ./utils.nix { inherit pkgs; };
  ops = import ./ops.nix { inherit pkgs; };
  devops = import ./devops.nix { inherit pkgs; };
  chat = import ./chat.nix { inherit pkgs; };
  desktop = import ./x.nix { inherit pkgs; };
  gaming = import ./gaming.nix { inherit pkgs; };
in builtins.concatLists [
  utils
  ops
  devops
  chat
  desktop
  gaming
  # [ daedalus ] # .outputs.${pkgs.system}.daedalus.packages.default ]
]
