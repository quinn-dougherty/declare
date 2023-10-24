{
  description = "quinnd's NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
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
    smos = {
      url = "github:NorfairKing/smos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hercules-ci-agent = {
      url = "github:hercules-ci/hercules-ci-agent";
      # inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    hercules-ci-effects = {
      url = "github:hercules-ci/hercules-ci-effects";
      # inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    nixinate = {
      url = "github:matthewcroughan/nixinate";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager
    , mobile-nixos, nix-doom-emacs, smos, hercules-ci-agent, hercules-ci-effects
    , nixinate }:
    let
      lib = nixpkgs.lib;
      machines = import ./common/machines.nix {
        inherit nixpkgs nixpkgs-stable hercules-ci-effects;
      };
      laptop = import ./laptop {
        inherit lib nixos-hardware home-manager nix-doom-emacs smos;
        laptop = machines.laptop;
      };
      server = import ./server {
        inherit lib nixos-hardware hercules-ci-agent;
        server = machines.server;
      };
      phone = import ./phone {
        inherit lib home-manager mobile-nixos;
        phone = machines.phone;
      };
      ubuntu = import ./ubuntu {
        inherit lib home-manager nix-doom-emacs;
        ubuntu = machines.ubuntu;
      };
      chat = import ./chat {
        inherit lib;
        chat = machines.chat;
      };
      common = import ./common {
        inherit machines;
        outputs = self;
        server-deploy = server.deploymenteffect;
      };
      immobiles = [ laptop server chat ];
      mobiles = [ phone ];
      other = [ ubuntu ];
    in with common; {
      apps = nixinate.nixinate.${machines.common.system} self;

      nixosConfigurations = commonlib.osForAll (immobiles ++ mobiles);

      homeConfigurations = commonlib.hmForAll other;

      # Just aliases to `nix build .#<machine.hostname>`
      packages.${machines.common.system} =
        commonlib.packagesFromAllOs { inherit immobiles mobiles other; };

      devShells.${laptop.system}."${laptop.drv-name-prefix}homeshell" =
        laptop.homeshell;

      checks.${machines.common.system}.lint = lint;

      herculesCI = herc;
    };
}
