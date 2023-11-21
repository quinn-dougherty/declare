{ lib, ubuntu, home-manager, nix-doom-emacs }:

ubuntu // (with ubuntu; {
  homemanager = import ./home.nix { inherit ubuntu home-manager; };
  homeshell = { };
})
