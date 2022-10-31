{ config, lib, pkgs, ... }:

{
  services = {
    hercules-ci-agent = {
      enable = true;
      settings.concurrentTasks = "auto";
    };
    openssh = {
      enable = true;
      # require public key authentication for better security
      passwordAuthentication = false;
      kbdInteractiveAuthentication = false;
    };
  };
  networking.firewall.allowedTCPPorts = [ 443 ];
  environment.systemPackages = let packages = ./../packages;
  in builtins.concatLists [
    (import "${packages}/utils.nix" { pkgs = pkgs; })
    (import "${packages}/devops.nix" { pkgs = pkgs; })
    (import "${packages}/observability.nix" { pkgs = pkgs; })
  ];
}
