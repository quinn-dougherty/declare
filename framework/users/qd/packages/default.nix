{ pkgs }:

let
  utils = import ./../../../../common/packages/utils.nix { inherit pkgs; };
  observability =
    import ./../../../../common/packages/observability.nix { inherit pkgs; };
  ops = import ./ops.nix { inherit pkgs; };
  chat = import ./chat.nix { inherit pkgs; };
  desktop = import ./x.nix { inherit pkgs; };
  gaming = import ./gaming.nix { inherit pkgs; };
in builtins.concatLists [
  utils
  observability
  ops
  chat
  desktop
  gaming
  # [ daedalus ] # .outputs.${pkgs.system}.daedalus.packages.default ]
]
