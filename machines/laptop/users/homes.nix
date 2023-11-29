{ laptop, inputs, config, pkgs, ... }:
with inputs; {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = let secrets = config.secrix.system.secrets;
    in { inherit laptop inputs secrets; };
    users = {
      ${laptop.username} = import ./qd/home.nix;
      root = import ./root/home.nix;
    };
  };
}
