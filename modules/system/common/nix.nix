{ inputs, pkgs, ... }:

{
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    #   min-free = ${toString (2048 * 1024 * 1024)}
    #   max-free = ${toString (16 * 2048 * 1024 * 1024)}
    settings.auto-optimise-store = true;
    gc = {
      dates = "daily";
      options = "--delete-older-than 111d";
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    package = inputs.nix-latest.packages.${pkgs.system}.default;
  };
}
