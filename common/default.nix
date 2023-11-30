{ self, machines, treefmt-nix, server-deploy }: {
  utils = import ./utils.nix;
  herculesCI = import ./herc.nix { inherit self machines server-deploy; };
  format = with machines;
    import ./format.nix { inherit common-machines treefmt-nix; };
}
