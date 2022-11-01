{ framework, nix-doom-emacs, agenix }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${framework.username} =
        import ./../users/qd/home.nix { inherit framework nix-doom-emacs; };
      root = import ./../users/root/home.nix { inherit framework agenix; };
    };
    # extraSpecialArgs.daedalus = daedalus;  # Passes more arguments to home.nix
  };
}
