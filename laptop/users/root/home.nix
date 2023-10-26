{ laptop, ... }:
with laptop; {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    git = import ./../git.nix;
    vim = import ./../vim.nix;
    # let home-manager install and update itself
    home-manager.enable = true;
  };

  home = {
    username = "root";
    homeDirectory = "/root";

    # You can update home-manager without changing this value
    stateVersion = "20.09";
  };
}
