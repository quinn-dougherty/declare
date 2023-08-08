{ pinephone }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.${pinephone.username} =
      import ./../users/qd/home.nix { inherit pinephone; };
  };
}
