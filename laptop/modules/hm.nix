{ laptop, nix-doom-emacs, smos }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${laptop.username} =
        import ./../users/qd/home.nix { inherit laptop nix-doom-emacs smos; };
      root = import ./../users/root/home.nix { inherit laptop; };
    };
    # extraSpecialArgs.daedalus = daedalus;  # Passes more arguments to home.nix
  };
}
