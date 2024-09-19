{ inputs, laptop }:
let
  modpath = "${inputs.self}/modules/system";
in
with inputs;
[
  ./system/configuration.nix
  "${modpath}/desktops/${laptop.desktop}"
  ./system/hardware-configuration.nix
  nixos-hardware.nixosModules.framework-13th-gen-intel
  secrix.nixosModules.default
  home-manager.nixosModules.home-manager
  ./users/homes.nix
  "${modpath}/manyterms.nix"
  "${modpath}/desktops/fonts.nix"
  "${modpath}/desktops/audio.nix"
  "${modpath}/bluetooth.nix"
  "${modpath}/crosscompilation.nix"
  "${modpath}/desktops/il8n.nix"
  # "${modpath}/nvidia.nix"
  # "${modpath}/games.nix"
  "${modpath}/battlenet.nix"
  inputs.nixos-generators.nixosModules.all-formats
  {
    imports = [ "${modpath}/emacs" ];
    editors.emacs = {
      enable = true;
      doom.enable = true;
    };
  }
  "${modpath}/ld.nix"
  "${modpath}/virtualbox.nix"
  "${modpath}/virtualization.nix"
]
++ import "${modpath}/common"
