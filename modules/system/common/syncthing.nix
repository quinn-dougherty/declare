{
  machine,
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

{
  services.syncthing = {
    enable = true;
    settings = {
      folders = {
        "${machine.username}" = {
          path = "/home/${machine.username}";
          devices = [ machine.hostname ];
        };
        versioning = {
          type = "staggered";
          params = {
            cleanInterval = "3600";
            maxAge = "15768000";
          };
        };
      };
      devices = {
        "${machine.hostname}" = {
          name = "${machine.hostname}";
          addresses = [ "dynamic" ];
        };
      };
    };
  };
}
