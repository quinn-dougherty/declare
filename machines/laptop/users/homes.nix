{ laptop, inputs, config, pkgs, ... }:
with inputs;
let modpath = "${self}/modules/hm";
in with laptop; {
  imports = [ "${self}/secrets" ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = let secrets = config.secrix.system.secrets;
    in { inherit laptop inputs secrets; };
    users = {
      ${username} = import ./qd/home.nix;
      # home-manager.lib.homeManagerConfiguration {
      # inherit pkgs;
      # modules = import ./qd/imports.nix { inherit inputs system username desktop; };
      # };
      root = import ./root/home.nix;
    };
  };
}
