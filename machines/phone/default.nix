{ lib, phone, inputs }:
{
  inherit (phone) system hostname;
  operatingsystem = lib.nixosSystem {
    specialArgs = { inherit lib phone inputs; };
    system = phone.system;
    modules =
      import ./modules { inherit lib phone inputs; };
  };
}
