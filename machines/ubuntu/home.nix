{ ubuntu, home-manager, ... }:
with ubuntu;
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules = let
    modpath = ./../../modules/hm;
    homeDirectory = "/home/${username}";
  in [
    "${modpath}/git.nix"
    "${modpath}/vim.nix"
    "${modpath}/ops.nix"
    "${modpath}/comms.nix"
    "${modpath}/direnv.nix"
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
        systemDirs.data =
          [ "${homeDirectory}/.nix-profile/share/applications" ];
      };
      #home.activation = {
      #  linkDesktopApplications = {
      #    after = [ "writeBoundary" "createXdgUserDirectories" ];
      #    before = [ ];
      #    data = ''
      #      rm -rf $HOME/.home-manager-share
      #      mkdir -p $HOME/.home-manager-share
      #      cp -Lr --no-preserve=mode,ownership ${homeDirectory}/.nix-profile/share/* $HOME/.home-manager-share
      #    '';
      #  };
      #};
    }
    { programs.fish.enable = true; }
  ];
}
