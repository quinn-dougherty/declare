{ pkgs }:

let
  ops = import ./ops.nix { inherit pkgs; };
  chat = import ./chat.nix { inherit pkgs; };
  desktop = import ./x.nix { inherit pkgs; };
  utils = import ./utils.nix { inherit pkgs; };
  gaming = import ./gaming.nix { inherit pkgs; };
in builtins.concatLists [
  ops
  chat
  desktop
  utils
  gaming
  # [ daedalus ] # .outputs.${pkgs.system}.daedalus.packages.default ]
]
