{
  description = "Quinn's personal infra hub";

  inputs = {
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";
    nixpkgs-2305.url = "nixpkgs/nixos-23.05";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nix-latest.url = "github:nixos/nix/latest-release";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators.url = "github:nix-community/nixos-generators";
    secrix.url = "github:Platonic-Systems/secrix";
    mobile-nixos = {
      url = "github:nixos/mobile-nixos";
      flake = false;
    };
    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-seafile-10.url = "github:greizgh/nixpkgs/seafile-10";
    smos.url = "github:NorfairKing/smos";
    hercules-ci-agent.url = "github:hercules-ci/hercules-ci-agent";
    hercules-ci-effects = {
      url = "github:hercules-ci/hercules-ci-effects";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs-master, nixpkgs, nixpkgs-stable, nixpkgs-2305
    , nixos-hardware, nix-latest, home-manager, nixos-generators, secrix
    , mobile-nixos, nix-doom-emacs, treefmt-nix, nixpkgs-seafile-10, smos
    , hercules-ci-agent, hercules-ci-effects }@inputs:
    with import ./machines { inherit inputs; };
    let
      website = with common;
        import ./website/soupault.nix { inherit pkgs self; };
      operations =
        let machines = { inherit laptop server phone ubuntu common; };
        in import ./operations.nix {
          inherit self machines treefmt-nix;
          server-deploy = server.deploymenteffect;
        };
      utils = import ./machines/utils.nix;
      immobiles = [ laptop server ];
      mobiles = [ phone ];
      nonNixos = [ ubuntu ];
    in with operations; {
      nixosConfigurations = utils.osForAll (immobiles ++ mobiles);
      homeConfigurations = utils.hmForAll (nonNixos ++ [ laptop ]);
      packages.${common.system} = {
        inherit website;
      } // (utils.packagesFromAllOs { inherit immobiles mobiles nonNixos; });
      devShells.${laptop.system} = {
        "${laptop.drv-name-prefix}:homeshell" = laptop.homeshell;
      } // (with common; import ./shells { inherit pkgs pkgs-stable; });
      apps.${laptop.system}.secrix = secrix.secrix self;
      inherit formatter checks herculesCI;
    };
}
