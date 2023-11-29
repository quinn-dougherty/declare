{ laptop, inputs, config, ... }:
with inputs; {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = let secrets = config.secrix.system.secrets;
    in { inherit laptop inputs secrets; };
    users = {
      ${laptop.username} =
        import ./qd/home.nix { inherit laptop inputs secrets; };
      root = import ./root/home.nix { inherit laptop; };
    };
  };
}
