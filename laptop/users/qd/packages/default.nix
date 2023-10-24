{ pkgs }:

let
  ops = import ./ops.nix { inherit pkgs; };
  comms = import ./comms.nix { inherit pkgs; };
  gaming = import ./gaming { inherit pkgs; };
  fonts = with pkgs; [ mononoki iosevka emacs-all-the-icons-fonts emacsPackages.treemacs-all-the-icons emacsPackages.all-the-icons-dired ];
in builtins.concatLists [ ops comms gaming fonts ]
