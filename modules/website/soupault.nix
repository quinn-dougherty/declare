{ pkgs, self, ... }:

pkgs.stdenv.mkDerivation {
  name = "quinn-dougherty.com-soupault";
  src = "${self}/website";
  buildInputs = with pkgs; [ soupault pandoc ];
  buildPhase = "soupault";
  installPhase = ''
    mkdir -p $out
    cp -r build/* $out
  '';
}
