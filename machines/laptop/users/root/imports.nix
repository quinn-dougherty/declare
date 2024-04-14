{ modpath }:
[
  {
    home = {
      username = "root";
      homeDirectory = "/root";
      stateVersion = "24.05";
    };
  }
  "${modpath}/vim.nix"
  "${modpath}/git.nix"
  {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  }
]
