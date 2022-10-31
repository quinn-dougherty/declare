{ nixpkgs, nixpkgs-stable, python-on-nix, hercules-ci-effects }:
let machines = fromTOML (builtins.readFile ./machines.toml);
in {
  common = machines.common // {
    pkgs = import nixpkgs { system = machines.common.system; };
  };
  framework = rec {
    hostname = machines.framework.hostname;
    username = machines.framework.username;
    user-fullname = machines.framework.user-fullname;
    system = machines.common.system;
    timezone = machines.common.timezone;
    drv-name-prefix = "${username}@${hostname}:";
    overlays = let
      factorio-overlay = final: prev: {
        factorio = prev.factorio.override {
          username = "quinnd";
          token = "\${FACTORIO_KEY}";
        };
      };
      python-on-nix-overlay = final: prev: {
        python-on-nix = python-on-nix.lib.${system};
      };
    in [ factorio-overlay python-on-nix-overlay ];
    config.allowUnfree = true;
    pkgs = import nixpkgs { inherit system overlays config; };
    pkgs-stable = import nixpkgs-stable { inherit system overlays config; };
  };
  agent-digitalocean = rec {
    hostname = machines.agent-digitalocean.hostname;
    username = machines.agent-digitalocean.username;
    user-fullname = machines.agent-digitalocean.user-fullname;
    system = machines.common.system;
    timezone = machines.common.timezone;
    ip = machines.agent-digitalocean.ip;
    volume = machines.agent-digitalocean.volume;
    overlays = [ hercules-ci-effects.overlay ];
    pkgs = import nixpkgs-stable { inherit system overlays; };
  };
  agent-latitude = rec {
    hostname = machines.agent-latitude.hostname;
    username = machines.agent-latitude.username;
    user-fullname = machines.agent-latitude.user-fullname;
    system = machines.common.system;
    timezone = machines.common.timezone;
    ip = machines.agent-latitude.ip;
    overlays = [ hercules-ci-effects.overlay ];
    config.allowUnfree = true;
    pkgs = import nixpkgs-stable { inherit system config overlays; };
  };
}
