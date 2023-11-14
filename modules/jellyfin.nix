{ server, ... }:

{
  services = {
    jellyfin = {
      enable = true;
      user = server.username;
    };
    jellyseerr.enable = true;
  };
}
