{ phone }:
with phone; {
  programs = {
    home-manager.enable = true;
    firefox.enable = true;
  };
  imports = let modpath = ./../../../../modules/hm;
  in [ "${modpath}/git.nix" "${modpath}/vim.nix" ];
  home = {
    username = username;
    homeDirectory = "/home/" + username;
    packages = import ./packages { inherit pkgs; };

    # You can update home-manager without changing this value
    stateVersion = "23.11";
  };

}
