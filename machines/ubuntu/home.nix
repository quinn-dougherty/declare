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
      xdg.mime.enable = true;
      programs.bash = {
        enable = true;
        profileExtra = ''
          export XDG_DATA_DIRS=$HOME/.home-manager-share:$XDG_DATA_DIRS
        '';
      };

      home.activation = {
        linkDesktopApplications = {
          after = [ "writeBoundary" "createXdgUserDirectories" ];
          before = [ ];
          data = ''
            rm -rf $HOME/.home-manager-share
            mkdir -p $HOME/.home-manager-share
            cp -Lr --no-preserve=mode,ownership ${config.home.homeDirectory}/.nix-profile/share/* $HOME/.home-manager-share
          '';
        };
      };
    }
    { programs.fish.enable = true; }
  ];
}
