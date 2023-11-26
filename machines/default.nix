{ inputs }:
with import ./machines.nix { inherit inputs; };
let lib = inputs.nixpkgs.lib;
in {
  common-machines = common;
  laptop = import ./laptop { inherit lib inputs laptop; };
  server = import ./server { inherit lib inputs server; };
  phone = import ./phone { inherit lib inputs phone; };
  #monitor = import ./monitor {
  #  inherit lib inputs monitor;
  #};
  ubuntu = import ./ubuntu {
    inherit lib ubuntu;
    inherit (inputs) home-manager nix-doom-emacs;
  };
}
