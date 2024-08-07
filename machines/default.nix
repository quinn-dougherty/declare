{ inputs }:
with import ./machines.nix { inherit inputs; };
let
  lib = inputs.nixpkgs.lib;
in
{
  inherit common;
  laptop = import ./laptop { inherit lib inputs laptop; };
  server = import ./server { inherit lib inputs server; };
  # phone = import ./phone { inherit lib inputs phone; };
  uptime = import ./uptime { inherit lib inputs uptime; };
  ubuntu = import ./ubuntu { inherit lib inputs ubuntu; };
}
