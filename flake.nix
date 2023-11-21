{
  description = "Quinn's personal infra hub";

  inputs = {
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixos.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.05";
    nixpkgs-2305.url = "nixpkgs/nixos-23.05";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mobile-nixos = {
      url = "github:nixos/mobile-nixos";
      flake = false;
    };
    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrix.url = "github:Platonic-Systems/secrix";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    smos.url = "github:NorfairKing/smos";
    hercules-ci-agent.url = "github:hercules-ci/hercules-ci-agent";
    hercules-ci-effects.url = "github:hercules-ci/hercules-ci-effects";
  };

  outputs =
    { self
    , nixpkgs-master
    , nixpkgs
    , nixos
    , nixpkgs-stable
    , nixpkgs-2305
    , nixos-hardware
    , home-manager
    , mobile-nixos
    , nix-doom-emacs
    , secrix
    , treefmt-nix
    , smos
    , hercules-ci-agent
    , hercules-ci-effects
    }@inputs: with import ./machines { inherit inputs; };
    let
      website = with common-machines; import ./modules/website/soupault.nix { inherit pkgs self; };
      flk-common = let machines = { inherit laptop server phone ubuntu common-machines; }; in import ./common {
        inherit self machines treefmt-nix;
        server-deploy = server.deploymenteffect;
      };
      immobiles = [ laptop server ];
      mobiles = [ phone ];
      others = [ ubuntu ];
    in
    with flk-common; {
      nixosConfigurations = commonlib.osForAll (immobiles ++ mobiles);
      homeConfigurations = commonlib.hmForAll others;
      packages.${common-machines.system} = { inherit website; } // (commonlib.packagesFromAllOs { inherit immobiles mobiles others; });
      devShells.${laptop.system} = {
        "${laptop.drv-name-prefix}:homeshell" = laptop.homeshell;
      } // (with common-machines;
        import ./shells { inherit pkgs pkgs-stable; });
      apps.${laptop.system}.secrix = secrix.secrix self;
      formatter.${common-machines.system} = format.config.build.wrapper;
      checks.${common-machines.system}.formatted =
        format.config.build.check self;
      herculesCI = herc;
    };
}
