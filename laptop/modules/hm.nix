{ framework, nix-doom-emacs, smos }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${framework.username} = import ./../users/qd/home.nix {
        inherit framework nix-doom-emacs smos;
      };
      root = import ./../users/root/home.nix { inherit framework; };
    };
    # extraSpecialArgs.daedalus = daedalus;  # Passes more arguments to home.nix
  };
}
