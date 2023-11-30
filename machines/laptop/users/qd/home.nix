{ laptop, inputs, secrets, doom, ... }:
with laptop;
let
  modpath = "${inputs.self}/modules/hm";
  imports = [
    {
      programs.firefox.enable = true;
      home = {
        username = username;
        homeDirectory = "/home/" + username;
        stateVersion = "24.05";
      };
    }
    "${modpath}/mail"
    "${modpath}/git.nix"
    "${modpath}/vim.nix"
    "${modpath}/codium.nix"
    "${modpath}/comms.nix"
    "${modpath}/ops.nix"
    "${modpath}/emacstools.nix"
    "${modpath}/direnv.nix"
    # "${modpath}/games.nix"
    { services = if desktop == "xmonad" then import ./xservices.nix else { }; }
    {
      imports = [ inputs.smos.homeManagerModules.${system}.default ];
      programs.smos.enable = true;
    }
  ]; # ++ (if desktop == "kde" then [ "${modpath}/desktops/kde/settings.nix" ] else [ ]);
in { inherit imports; }
