{ phone }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.${phone.username} = import ./../users/qd/home.nix { inherit phone; };
  };
}
