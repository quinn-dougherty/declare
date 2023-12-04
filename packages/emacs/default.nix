{ inputs, pkgs, ... }:
let
  doomPrivateDir = ./doom.d;
  doomPackageDir = let
    filteredPath = builtins.path {
      path = doomPrivateDir;
      name = "doom-private-dir-filtered";
      filter = path: type:
        builtins.elem (baseNameOf path) [ "init.el" "packages.el" ];
    };
  in pkgs.linkFarm "doom-packages-dir" [
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
      path = pkgs.emptyFile;
    }
  ];
  extraPackages = import ./tools { inherit inputs pkgs; };
in inputs.nix-doom-emacs.packages.${pkgs.system}.default.override {
  inherit doomPrivateDir doomPackageDir extraPackages;
}
