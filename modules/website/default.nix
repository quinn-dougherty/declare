{ pkgs, ... }:

let
  site = import ./soupault.nix { inherit pkgs; };
  nginx = import ./nginx.nix {
    inherit site;
  };
in
{
  imports = [ nginx ];
}
