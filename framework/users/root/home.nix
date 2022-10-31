{ framework, ... }:
with framework; {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    # fish.enable = true;

    # let home-manager install and update itself
    home-manager.enable = true;
  };

  home = {
    packages = builtins.concatLists [
      (import ../common/utils.nix { inherit pkgs; })
      (import ../common/devops.nix { inherit pkgs; })
    ];
    username = "root";
    homeDirectory = "/root";

    # You can update home-manager without changing this value
    stateVersion = "20.09";
  };
}
