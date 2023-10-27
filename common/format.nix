{ common, treefmt-nix }:
with common;
treefmt-nix.lib.evalModule pkgs ({ pkgs, ... }: {
  projectRootFile = "./../flake.nix";
  programs = {
    prettier.enable = true;
    stylish-haskell.enable = true;
    nixpkgs-fmt.enable = true;
  };
  settings.formatter.terraform.excludes = readFile ./../.gitignore;
})
