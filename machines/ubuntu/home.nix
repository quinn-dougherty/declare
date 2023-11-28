{ ubuntu, home-manager, ... }:
with ubuntu;
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules = let modpath = ./../../modules/hm;
  in [
    "${modpath}/git.nix"
    "${modpath}/vim.nix"
    "${modpath}/ops.nix"
    "${modpath}/comms.nix"
    "${modpath}/direnv.nix"
    {
      programs.home-manager.enable = true;
      home = {
        username = username;
        homeDirectory = "/home/${username}";
        stateVersion = "23.11";
      };
    }
    {
      targets.genericLinux.enable = true;
      home.activation = {
        linkDesktopApplications = {
          after = [ "writeBoundary" "createXdgUserDirectories" ];
          before = [ ];
          data =
            "/usr/bin/sudo /usr/bin/chmod -R 777 $HOME/.nix-profile/share/applications && /usr/bin/update-desktop-database $HOME/.nix-profile/share/applications";
        };
      };
    }
  ];
}
