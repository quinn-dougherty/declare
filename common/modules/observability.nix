{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    htop
    tcpdump
    termshark
    conntrack-tools
  ];
  programs = {
    mtr.enable = true;
    wireshark.enable = true;
  };
  services.avahi.enable = true;
}
