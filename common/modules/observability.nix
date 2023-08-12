{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    lm_sensors
    tcpdump
    termshark
    conntrack-tools
  ];
  programs = {
    mtr.enable = true;
    wireshark.enable = true;
    htop = {
      enable = true;
      settings.show_cpu_temperature = 1;
    };
  };
  services.avahi.enable = true;
}
