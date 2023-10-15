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
      machines = import ./common/machines.nix {
        inherit nixpkgs nixpkgs-stable hercules-ci-effects;
      };
      framework = import ./framework {
        inherit nixos-hardware home-manager nix-doom-emacs smos;
        lib = nixpkgs.lib;
        framework = machines.framework;
      };
      agent-digitalocean = import ./agent-digitalocean {
        inherit hercules-ci-agent;
        lib = nixpkgs.lib;
        agent = machines.agent-digitalocean;
      };
      agent-latitude = import ./agent-latitude {
        inherit hercules-ci-agent nixos-hardware;
        lib = nixpkgs.lib;
        agent = machines.agent-latitude;
      };
      pinephone = import ./phone {
        inherit home-manager mobile-nixos;
        lib = nixpkgs.lib;
        pinephone = machines.pinephone;
      };
      chat = import ./matrix-server {
        lib = nixpkgs.lib;
        chat = machines.chat;
      };
      common = import ./common {
        inherit machines;
        outputs = self;
        agent-digitalocean-deploy = agent-digitalocean.deploymenteffect;
        agent-latitude-deploy = agent-latitude.deploymenteffect;
      };
      immobiles = [ framework agent-digitalocean agent-latitude chat ];
      mobiles = [ pinephone ];
    in with common; {
      apps = nixinate.nixinate.${machines.common.system} self;

      nixosConfigurations = commonlib.osForAll (immobiles ++ mobiles);

      # Just aliases to `nix build .#<machine.hostname>`
      packages.${machines.common.system} =
        commonlib.packagesFromAllOs { inherit immobiles mobiles; };

      devShells.${framework.system}."${framework.drv-name-prefix}homeshell" =
        framework.homeshell;

      checks.${machines.common.system}.lint = lint;

      herculesCI = herc;
    };
}
