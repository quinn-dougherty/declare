{ ubuntu, home-manager, ... }: with ubuntu;
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules = let modpath = ./../../modules/hm; in [
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
  ];
}
