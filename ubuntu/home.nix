# This is a stub currently, it doesn't even get called
{ pkgs, home-manager, nix-doom-emacs, username }:

{
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    git = import ./../git.nix;
    vim = import ./../vim.nix;
  };
  imports = [ nix-doom-emacs.hmModule ./../../common/modules/hm/emacs ];
  # services.dropbox.enable = true;
  home = {
    packages = import ./packages { inherit pkgs; };
    username = username;
    homeDirectory = "/home/" + username;

    # You can update home-manager without changing this value
    stateVersion = "20.09";
  };
}
