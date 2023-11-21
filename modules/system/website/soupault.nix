{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "quinn-dougherty.com-soupault";
  src = ./soupault;
  buildInputs = [ pkgs.soupault pkgs.pandoc ];
  buildPhase = "soupault";
  installPhase = ''
    mkdir -p $out
    cp -r build/* $out
  '';
}
