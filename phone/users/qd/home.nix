{ pinephone }:
with pinephone; {
  programs = {
    home-manager.enable = true;
    firefox.enable = true;
    git.enable = true;
    vim.enable = true;
  };

  home = {
    username = username;
    homeDirectory = "/home/" + username;
    packages = import ./packages { inherit pkgs; };

    # You can update home-manager without changing this value
    stateVersion = "22.05";
  };

}
