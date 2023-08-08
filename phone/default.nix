{ lib, pinephone, home-manager, mobile-nixos }:

pinephone // {
  operatingsystem = lib.nixosSystem {
    system = pinephone.system;
    modules = import ./modules { inherit pinephone home-manager mobile-nixos; };
  };
}
