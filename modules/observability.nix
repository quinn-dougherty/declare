{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    lm_sensors
    xsensors
    inxi
    tcpdump
    termshark
    conntrack-tools
    linuxKernel.packages.linux_libre.perf
    # postman
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
