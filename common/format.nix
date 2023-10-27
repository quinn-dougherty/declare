{ common, treefmt-nix }:
treefmt-nix.lib.evalModule common.pkgs ({ pkgs, ... }: {
  projectRootFile = "flake.nix";
  programs = {
    prettier.enable = true;
    stylish-haskell.enable = true;
    nixpkgs-fmt.enable = true;
  };
})
