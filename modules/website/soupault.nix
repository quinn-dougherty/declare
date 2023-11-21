{ pkgs, self, ... }:

pkgs.stdenv.mkDerivation {
  name = "quinn-dougherty.com-soupault";
  src = "${self}/website";
  buildInputs = [ pkgs.soupault pkgs.pandoc ];
  buildPhase = "soupault";
  installPhase = ''
    mkdir -p $out
    cp -r build/* $out
  '';
}
