{ nixpkgs, nixpkgs-stable, hercules-ci-effects }:
let
  machines = fromTOML (builtins.readFile ./machines.toml);
  agent-onprem-tz = "America/Los_Angeles";
  herc-effects-overlays = [ hercules-ci-effects.overlay ];
in {
  common = machines.common // {
    pkgs = import nixpkgs {
      system = machines.common.system;
      overlays = herc-effects-overlays;
    };
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
    in [ factorio-overlay ];
    config.allowUnfree = true;
    pkgs = import nixpkgs { inherit system overlays config; };
    pkgs-stable = import nixpkgs-stable { inherit system overlays config; };
  };
  pinephone = rec {
    hostname = machines.pinephone.hostname;
    username = machines.pinephone.username;
    user-fullname = machines.pinephone.user-fullname;
    system = machines.pinephone.system;
    timezone = machines.common.timezone;
    config.allowUnfree = true;
    pkgs = import nixpkgs { inherit system config; };
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
    pkgs = import nixpkgs {
      inherit system;
      overlays = herc-effects-overlays;
    };
  };
  agent-latitude = rec {
    hostname = machines.agent-latitude.hostname;
    username = machines.agent-latitude.username;
    user-fullname = machines.agent-latitude.user-fullname;
    system = machines.common.system;
    timezone = agent-onprem-tz;
    ip = machines.agent-latitude.ip;
    config.allowUnfree = true;
    pkgs = import nixpkgs {
      inherit system config;
      overlays = herc-effects-overlays;
    };
  };
  chat = rec {
    hostname = machines.chat.hostname;
    username = machines.chat.username;
    user-fullname = machines.chat.user-fullname;
    system = machines.common.system;
    timezone = machines.common.timezone;
    ip = machines.chat.ip;
    pkgs = import nixpkgs { inherit system; };
  };
}
