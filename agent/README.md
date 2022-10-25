# Herc CI agent

I began with a starter image for a digital ocean droplet, found [here](https://justinas.org/nixos-in-the-cloud-step-by-step-part-1)

```nix
{ pkgs ? import <nixpkgs> { } }:
let config = {
  imports = [ <nixpkgs/nixos/modules/virtualisation/digital-ocean-image.nix> ];
};
in
(pkgs.nixos config).digitalOceanImage
```

I then built out from `nixos-generate-config` on the box and enabled the hercules agent.

I deploy with [`nixinate`](https://github.commatthewcroughan/nixinate).
