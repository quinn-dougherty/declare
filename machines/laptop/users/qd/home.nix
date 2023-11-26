{ laptop, inputs, ... }:
with laptop;
let modpath = ./../../../../modules/hm;
in {
  programs.smos.enable = true;
  imports = [
    inputs.nix-doom-emacs.hmModule
    "${modpath}/emacs"
    "${modpath}/git.nix"
    "${modpath}/vim.nix"
    "${modpath}/codium.nix"
    "${modpath}/comms.nix"
    "${modpath}/ops.nix"
    "${modpath}/direnv.nix"
    inputs.smos.homeManagerModules.${system}.default
  ]; # ++ (if desktop == "kde" then [ "${modpath}/desktops/kde/settings.nix" ] else [ ]);
  home = {
    username = username;
    homeDirectory = "/home/" + username;

    # You can update home-manager without changing this value
    stateVersion = "20.09";
  };
  services = if desktop == "xmonad" then import ./xservices.nix else { };
}
