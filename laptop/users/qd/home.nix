{ laptop, nix-doom-emacs, smos, ... }:
with laptop; {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    git = import ./../git.nix;
    vim = import ./../vim.nix;
    smos.enable = true;
  };
  imports = [
    nix-doom-emacs.hmModule
    ./../../../common/modules/hm/emacs
    smos.homeManagerModules.${system}.default
    ./../../../common/modules/hm/gaming
  ];
  # services.dropbox.enable = true;
  home = {
    packages = import ./packages { inherit pkgs; };
    username = username;
    homeDirectory = "/home/" + username;

    # You can update home-manager without changing this value
    stateVersion = "20.09";
  };
  services = if desktop == "xmonad" then import ./services.nix else { };
}
