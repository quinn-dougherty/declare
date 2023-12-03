{ inputs }:
with inputs;
let
  machines = fromTOML (builtins.readFile ./machines.toml);
  server-onprem-tz = "America/Los_Angeles";
  herc-effects-overlays = [ hercules-ci-effects.overlay ];
  drv-name-prefix-Fn = { username, hostname }: "${username}@${hostname}";
  qd = "qd";
  admin = "admin";
in {
  common = machines.common // {
    pkgs = import nixpkgs {
      system = machines.common.system;
      overlays = herc-effects-overlays;
    };
    pkgs-stable = import nixpkgs-stable { system = machines.common.system; };
  };
  laptop = rec {
    hostname = machines.laptop.hostname;
    username = qd;
    user-fullname = machines.laptop.user-fullname;
    system = machines.common.system;
    timezone = machines.common.timezone;
    desktop = machines.laptop.desktop;
    drv-name-prefix = drv-name-prefix-Fn { inherit username hostname; };
    overlays = let
      factorio-overlay = final: prev: {
        factorio = prev.factorio.override {
          username = "quinnd";
          token = "\${FACTORIO_KEY}";
        };
      };
      mesa-backwards = final: prev: { mesa = pkgs-stable.mesa; };
    in [ factorio-overlay ];
    config.allowUnfree = true;
    pkgs = import nixpkgs { inherit system config; };
    pkgs-stable = import nixpkgs-stable { inherit system config; };
  };
  phone = rec {
    hostname = machines.phone.hostname;
    username = qd;
    user-fullname = machines.phone.user-fullname;
    system = machines.phone.system;
    timezone = machines.common.timezone;
    config.allowUnfree = true;
    pkgs = import nixpkgs { inherit system config; };
  };
  server = rec {
    hostname = machines.server.hostname;
    username = admin;
    user-fullname = machines.server.user-fullname;
    system = machines.common.system;
    timezone = server-onprem-tz;
    ip = machines.server.ip;
    static4 = machines.server.static4;
    overlays = let nps = nixpkgs-seafile.legacyPackages.${system};
    in [
      hercules-ci-effects.overlay
      (final: prev: {
        seafile-server = nps.seafile-server;
        seahub = nps.seahub;
      })
    ];
    pkgs = import nixpkgs {
      inherit system;
      overlays = herc-effects-overlays;
    };
  };
  ubuntu = rec {
    hostname = machines.ubuntu.hostname;
    username = qd;
    user-fullname = machines.ubuntu.user-fullname;
    system = machines.common.system;
    timezone = machines.common.timezone;
    drv-name-prefix = drv-name-prefix-Fn { inherit username hostname; };
    config.allowUnfree = true;
    pkgs = import nixpkgs { inherit system config; };
  };
}
