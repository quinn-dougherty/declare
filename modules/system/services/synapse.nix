{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./postgres.nix
    ./openssh.nix
  ];
  services = {

    postgresql.initialScript = pkgs.writeText "backend-initScript" ''
      CREATE USER "matrix-synapse";

      CREATE DATABASE "matrix-synapse"
      ENCODING 'UTF8'
      LC_COLLATE='C'
      LC_CTYPE='C'
      template=template0
      OWNER "matrix-synapse";
    '';
    matrix-synapse = {
      enable = true;
      settings = {
        server_name = "example.com";
        registration_shared_secret = "secret";
        extraConfig = ''
          max_upload_size: "50M"
        '';
        database = {
          name = "psycopg2";
          args.database = "matrix-synapse";
        };
      };
    };
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22 # SSH
      8448 # Matrix federation
    ];
  };
}
