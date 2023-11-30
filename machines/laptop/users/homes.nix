{ doom, laptop, inputs, config, pkgs, ... }:
with inputs; {
  imports = [ "${inputs.self}/secrets" ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = let secrets = config.secrix.system.secrets;
    in { inherit laptop inputs secrets doom; };
    users = {
      ${laptop.username} = import ./qd/home.nix;
      root = import ./root/home.nix;
    };
  };
}
