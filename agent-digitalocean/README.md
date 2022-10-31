# [Herc CI agent](https://docs.hercules-ci.com/hercules-ci-agent/) (disabled)

This is currently disabled, but I want to leave the code in the repo in case I need to spin one up in the cloud at some point.

## The process

I began with a starter image for a digital ocean droplet, found [here](https://justinas.org/nixos-in-the-cloud-step-by-step-part-1).

```nix
{ pkgs ? import <nixpkgs> { } }:
let config = {
  imports = [ <nixpkgs/nixos/modules/virtualisation/digital-ocean-image.nix> ];
};
in
(pkgs.nixos config).digitalOceanImage
```

I then built out from `nixos-generate-config` on the box and enabled the hercules agent.

I deploy with [`nixinate`](https://github.commatthewcroughan/nixinate) when I would like to do so manually, otherwise I use the `runNixOS` function from `hercules-ci-effects`.

## Imperative assumptions

This code currently assumes some imperative steps have been taken, like copying over a `hercules-ci-agent/secrets` directory manually.
