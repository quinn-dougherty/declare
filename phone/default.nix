{ lib, phone, home-manager, mobile-nixos }:

phone // {
  operatingsystem = lib.nixosSystem {
    system = phone.system;
    modules = import ./modules { inherit phone home-manager mobile-nixos; };
  };
}
