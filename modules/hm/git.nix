{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.git = {
    enable = true;
    userName = "Quinn Dougherty";
    userEmail = "quinn.dougherty.forall@gmail.com";
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
    ignores = [
      "*~"
      "*.swp"
      ".DS_Store"
      ".idea"
      ".direnv/"
    ];
    # github.user = "quinn-dougherty";
  };
}
