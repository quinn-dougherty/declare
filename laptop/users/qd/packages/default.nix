{ pkgs }:

let
  ops = import ./ops.nix { inherit pkgs; };
  comms = import ./comms.nix { inherit pkgs; };
  gaming = import ./gaming { inherit pkgs; };
  fonts = with pkgs; [ mononoki iosevka ];
in builtins.concatLists [ ops comms gaming fonts ]
