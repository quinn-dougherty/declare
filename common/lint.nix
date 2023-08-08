{ common }:
with common.pkgs;
stdenv.mkDerivation {
  name = "dotfiles-lint";
  src = ./../.;
  buildInputs = [ nixfmt nodePackages.prettier ];
  buildPhase = ''
    for nixfile in $(find $src -type f | grep '[.]nix')
    do
      nixfmt --check $nixfile
    done
    prettier --check $src --ignore-path .gitignore
  '';
  installPhase = "mkdir -p $out";
}
