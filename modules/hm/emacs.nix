{ config, lib, pkgs, ... }:
let
  emacs = { doomDir, linkFarm, emptyFile }: {
    enable = true;
    doomPrivateDir = doomDir;
    doomPackageDir = let
      filteredPath = builtins.path {
        path = doomDir;
        name = "doom-private-dir-filtered";
        filter = path: type:
          builtins.elem (baseNameOf path) [ "init.el" "packages.el" ];
      };
    in linkFarm "doom-packages-dir" [
      {
        name = "init.el";
        path = "${filteredPath}/init.el";
      }
      {
        name = "packages.el";
        path = "${filteredPath}/packages.el";
      }
      {
        name = "config.el";
        path = emptyFile;
      }
    ];
  };

in {
  imports = import ./tools { inherit pkgs; };
  programs.doom-emacs = let doomDir = ./doom.d;
  in with pkgs; emacs { inherit doomDir linkFarm emptyFile; };
}
