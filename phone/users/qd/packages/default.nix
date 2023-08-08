{ pkgs }:
let
  ops = import ./ops.nix { inherit pkgs; };
  terminals = import ./terminals.nix { inherit pkgs; };
  comms = import ./comms.nix { inherit pkgs; };
in builtins.concatLists [ ops terminals comms ]
