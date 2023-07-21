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
    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
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
    , nix-doom-emacs, hercules-ci-agent, hercules-ci-effects, nixinate }:
    let
      machines = import ./common/machines.nix {
        inherit nixpkgs nixpkgs-stable hercules-ci-effects;
      };
      framework = import ./framework {
        inherit nixos-hardware home-manager nix-doom-emacs;
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
      chat = import ./matrix-server {
        lib = nixpkgs.lib;
        chat = machines.chat;
      };
      util = import ./common {
        inherit machines;
        outputs = self;
        agent-digitalocean-deploy = agent-digitalocean.deploymenteffect;
        agent-latitude-deploy = agent-latitude.deploymenteffect;
      };
    in {
      apps = nixinate.nixinate.${machines.common.system} self;

      nixosConfigurations =
        util.osForAll [ framework agent-digitalocean agent-latitude chat ];

      devShells.${framework.system}."${framework.hostname}-homeshell" =
        framework.homeshell;

      checks.${machines.common.system}.lint = util.lint;

      herculesCI = util.herc;
    };
}
