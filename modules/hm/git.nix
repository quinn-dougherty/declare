{ config, lib, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Quinn Dougherty";
    userEmail = "quinnd@riseup.net";
    aliases = {
      s = "status";
      c = "commit";
      a = "add";
      p = "push";
      f = "fetch";
      ck = "checkout";
      b = "branch";
    };
    lfs.enable = true;
    ignores = [ "*~" "*.swp" ".DS_Store" ".idea" ];
    # init.defaultBranch = "main";
    # github.user = "quinn-dougherty";
  };
}
