{ lib, phone, inputs }: {
  inherit (phone) system hostname;
  operatingsystem = lib.nixosSystem {
    specialArgs = { inherit lib phone inputs; }; # inherit (phone) pkgs; };
    system = phone.system;
    modules = import ./modules { inherit inputs; };
  };
}
