{ machines, agent-digitalocean-deploy, agent-latitude-deploy, outputs }: {
  util = import ./utilities.nix;
  herc = import ./herc.nix {
    inherit outputs machines agent-digitalocean-deploy agent-latitude-deploy;
  };
  lint = with machines; import ./lint.nix { inherit common; };
}
