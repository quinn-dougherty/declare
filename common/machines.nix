{ nixpkgs, nixpkgs-stable, hercules-ci-effects }:
let
  machines = fromTOML (builtins.readFile ./machines.toml);
  server-onprem-tz = "America/Los_Angeles";
  herc-effects-overlays = [ hercules-ci-effects.overlay ];
  drv-name-prefix-Fn = { username, hostname }: "${username}@${hostname}:";
in {
  common = machines.common // {
    pkgs = import nixpkgs {
      system = machines.common.system;
      overlays = herc-effects-overlays;
    };
  };
  laptop = rec {
    hostname = machines.laptop.hostname;
    username = machines.laptop.username;
    user-fullname = machines.laptop.user-fullname;
    system = machines.common.system;
    timezone = machines.common.timezone;
    drv-name-prefix = drv-name-prefix-Fn { inherit username hostname; };
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
  phone = rec {
    hostname = machines.phone.hostname;
    username = machines.phone.username;
    user-fullname = machines.phone.user-fullname;
    system = machines.phone.system;
    timezone = machines.common.timezone;
    config.allowUnfree = true;
    pkgs = import nixpkgs { inherit system config; };
  };
  server = rec {
    hostname = machines.server.hostname;
    username = machines.server.username;
    user-fullname = machines.server.user-fullname;
    system = machines.common.system;
    timezone = server-onprem-tz;
    ip = machines.server.ip;
    static4 = machines.server.static4;
    pkgs = import nixpkgs {
      inherit system;
      overlays = herc-effects-overlays;
    };
  };
  ubuntu = rec {
    hostname = machines.ubuntu.hostname;
    username = machines.ubuntu.username;
    user-fullname = machines.ubuntu.user-fullname;
    system = machines.common.system;
    timezone = machines.common.timezone;
    drv-name-prefix = drv-name-prefix-Fn { inherit username hostname; };
    config.allowUnfree = true;
    pkgs = import nixpkgs { inherit system config; };
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
