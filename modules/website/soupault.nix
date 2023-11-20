{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "quinn-dougherty.com";
  src = ./../../website;
  buildInputs = [ pkgs.soupault ];
  buildPhase = "soupault";
  installPhase = ''
    mkdir -p $out
    cp -r build/* $out
  '';
}
