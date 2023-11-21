{ common-machines, treefmt-nix }:
treefmt-nix.lib.evalModule common-machines.pkgs ({ pkgs, ... }: {
  projectRootFile = "flake.nix";
  programs = {
    prettier.enable = true;
    stylish-haskell.enable = true;
    nixpkgs-fmt.enable = true;
  };
})
