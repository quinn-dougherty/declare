{ machines, treefmt-nix, server-deploy, outputs }: {
  commonlib = import ./lib.nix;
  herc = import ./herc.nix { inherit outputs machines server-deploy; };
  format = with machines; import ./format.nix { inherit common treefmt-nix; };
}
