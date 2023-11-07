{ lib, ubuntu, home-manager, nix-doom-emacs }:

ubuntu // (with ubuntu; {
  homemanager = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    modules = [{
      programs.home-manager.enable = true;
      home = {
        username = username;
        homeDirectory = "/home/" + username;
        packages = [ pkgs.vim ];
        stateVersion = "23.11";
      };
    }];
  };
  homeshell = { };
})
