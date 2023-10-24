{ lib, ubuntu, home-manager, nix-doom-emacs }:

ubuntu // (with ubuntu; {
  homemanager = home-manager.lib.homeManagerConfiguration {
    inherit pkgs system username;
    homeDirectory = "/home/${username}";
    configHome = "${homeDirectory}/.config";
    configuration = import ./home.nix;
  };
  homeshell = { };
})
