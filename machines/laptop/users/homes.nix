{ laptop, nix-doom-emacs, smos }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${laptop.username} =
        import ./qd/home.nix { inherit laptop nix-doom-emacs smos; };
      root = import ./root/home.nix { inherit laptop; };
    };
  };
}
