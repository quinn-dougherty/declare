{ pkgs, self, ... }:

pkgs.stdenv.mkDerivation {
  name = "quinn-dougherty.com-soupault";
  src = ./.;
  buildInputs = with pkgs; [ soupault pandoc ];
  buildPhase = "soupault";
  installPhase = ''
    mkdir -p $out
    cp -r build/* $out
  '';
}
