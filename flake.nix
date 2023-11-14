{
  description = "Quinn's personal infra hub";

  inputs = {
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixos.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.05";
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
    # secrix.url = "path:/home/qd/projects/secrix";
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
    , nixos-hardware
    , home-manager
    , mobile-nixos
    , nix-doom-emacs
    , secrix
    , treefmt-nix
    , smos
    , hercules-ci-agent
    , hercules-ci-effects
    }:
    let
      lib = nixpkgs.lib;
      machines = import ./machines/machines.nix {
        inherit nixpkgs-master nixpkgs nixpkgs-stable hercules-ci-effects;
      };
      web = with machines.common; import ./website { inherit pkgs; };
      laptop = import ./machines/laptop {
        inherit lib nixpkgs nixos-hardware secrix home-manager nix-doom-emacs smos;
        laptop = machines.laptop;
      };
      server = import ./machines/server {
        inherit nixpkgs lib nixos-hardware hercules-ci-agent secrix web;
        server = machines.server;
      };
      phone = import ./machines/phone {
        inherit nixpkgs lib home-manager mobile-nixos secrix;
        phone = machines.phone;
      };
      ubuntu = import ./machines/ubuntu {
        inherit lib home-manager nix-doom-emacs;
        ubuntu = machines.ubuntu;
      };
      chat = import ./machines/chat {
        inherit lib secrix;
        chat = machines.chat;
      };
      common = import ./common {
        inherit machines treefmt-nix;
        outputs = self;
        server-deploy = server.deploymenteffect;
      };
      immobiles = [ laptop server chat ];
      mobiles = [ phone ];
      others = [ ubuntu ];
    in
    with common; {
      formatter.${machines.common.system} = format.config.build.wrapper;

      nixosConfigurations = commonlib.osForAll (immobiles ++ mobiles);

      homeConfigurations = commonlib.hmForAll others;

      packages.${machines.common.system} = with web;
        {
          inherit site;
        }
        // (commonlib.packagesFromAllOs { inherit immobiles mobiles others; });

      devShells = {
        ${laptop.system} = {
          "${laptop.drv-name-prefix}:homeshell" = laptop.homeshell;
        } // (with machines.common;
          import ./shells { inherit pkgs pkgs-stable; });
      };

      apps.${laptop.system}.secrix = secrix.secrix self;

      checks.${machines.common.system}.formatted =
        format.config.build.check self;

      herculesCI = herc;
    };
}
