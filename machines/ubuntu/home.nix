{ ubuntu, home-manager, ... }:
with ubuntu;
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules =
    let
      modpath = ./../../modules/hm;
      homeDirectory = "/home/${username}";
    in
    [
      "${modpath}/git.nix"
      "${modpath}/vim.nix"
      "${modpath}/ops.nix"
      "${modpath}/utilities.nix"
      "${modpath}/comms.nix"
      "${modpath}/direnv.nix"
      # "${modpath}/gaming.nix"
      {
        programs.home-manager.enable = true;
        home = {
          inherit homeDirectory;
          username = username;
          stateVersion = "23.11";
        };
      }
      {
        targets.genericLinux.enable = true;
        xdg = {
          mime.enable = true;
          systemDirs.data = [ "${homeDirectory}/.nix-profile/share/applications" ];
        };
      }
      { programs.fish.enable = true; }
    ];
}
