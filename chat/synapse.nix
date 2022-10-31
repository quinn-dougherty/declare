{ config, lib, pkgs, ... }:

{
  services = {
    postgres = {
      enable = true;
      package = pkgs.postgresql_14;
      enableTCPIP = true;
      authentication = pkgs.lib.mkOverride 10 ''
        local all all trust
        host all all 127.0.0.1/32 trust
        host all all ::1/128 trust
      '';
      initialScript = pkgs.writeText "backend-initScript" ''
        CREATE USER "matrix-synapse";

        CREATE DATABASE "matrix-synapse"
        ENCODING 'UTF8'
        LC_COLLATE='C'
        LC_CTYPE='C'
        template=template0
        OWNER "matrix-synapse";
      '';
    };
    matrix-synapse = {
      enable = true;
      server_name = "example.com";
      registration_shared_secret = "secret";
      database_type = "psycopg2";
      database_args = { database = "matrix-synapse"; };
      extraConfig = ''
        max_upload_size: "50M"
      '';
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
