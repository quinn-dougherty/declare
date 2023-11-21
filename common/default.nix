{ self, machines, treefmt-nix, server-deploy }: {
  commonlib = import ./lib.nix;
  herc = import ./herc.nix { inherit self machines server-deploy; };
  format = with machines; import ./format.nix { inherit common-machines treefmt-nix; };
}
