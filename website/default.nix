{ pkgs, ... }: {
  site = pkgs.stdenv.mkDerivation {
    name = "quinn-dougherty.com-soupault";
    buildInputs = with pkgs; [ soupault pandoc ];
    src = ./.;
    buildPhase = "soupault";
    installPhase = ''
      mkdir -p $out
      cp -r build/* $out
    '';
  };
}
