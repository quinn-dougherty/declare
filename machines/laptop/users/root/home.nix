{ laptop, ... }:
with laptop;
let modpath = ./../../../../modules/hm;
in {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    home-manager.enable = true;
  };

  imports = [ "${modpath}/vim.nix" "${modpath}/git.nix" ];
  home = {
    username = "root";
    homeDirectory = "/root";

    stateVersion = "24.05";
  };
}
