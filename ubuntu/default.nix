{ lib, ubuntu, home-manager, nix-doom-emacs }:

with ubuntu;
home-manager.lib.homeManagerConfiguration {
  inherit pkgs system username;
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";
  configuration = import ./home.nix;
}
