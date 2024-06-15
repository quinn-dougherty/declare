{ config, machine, ... }:

{
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = config.nixpkgs.config.allowUnfree;
  };
  users.extraGroups.vboxusers.members = [ machine.username ];
}
