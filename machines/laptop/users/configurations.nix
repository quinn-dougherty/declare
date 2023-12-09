{ inputs, laptop, ... }:
with laptop;
let modpath = "${inputs.self}/modules/hm";
in {
  ${username} = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    modules = import ./qd/imports.nix {
      inherit inputs system modpath username desktop;
    };
  };
  root = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    modules = import ./root/imports.nix { inherit modpath; };
  };
}
