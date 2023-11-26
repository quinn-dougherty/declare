{ laptop, inputs, ... }:
with inputs; {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${laptop.username} = import ./qd/home.nix { inherit laptop inputs; };
      root = import ./root/home.nix { inherit laptop; };
    };
  };
}
