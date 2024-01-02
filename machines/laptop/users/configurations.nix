{ inputs, laptop }:
with laptop;
let
  # doom = import "${inputs.self}/packages/emacs" { inherit inputs pkgs; };
  modpath = "${inputs.self}/modules/hm";
  extraSpecialArgs = let secrets = config.secrix.system.secrets;
  in { inherit laptop inputs secrets; };
in {
  ${username} = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs extraSpecialArgs;
    modules = import ./qd/imports.nix {
      inherit inputs system modpath username desktop;
    };
  };
  root = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs extraSpecialArgs;
    modules = import ./root/imports.nix { inherit modpath; };
  };
}
