{ machines, server-deploy, outputs }: {
  commonlib = import ./lib.nix;
  herc = import ./herc.nix { inherit outputs machines server-deploy; };
  lint = with machines; import ./lint.nix { inherit common; };
}
