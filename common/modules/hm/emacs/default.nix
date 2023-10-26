{ config, lib, pkgs, ... }: {
  imports = [ ./tools ];
  programs.doom-emacs =
    let doomDir = ./doom.d;
    in with pkgs; import ./emacs.nix { inherit doomDir linkFarm emptyFile; };
}
