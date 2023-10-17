{ pkgs }:

let
  ops = import ./ops.nix { inherit pkgs; };
  comms = import ./comms.nix { inherit pkgs; };
  gaming = import ./gaming { inherit pkgs; };
  fonts = [ pkgs.mononoki ];
in builtins.concatLists [ ops comms gaming fonts ]
