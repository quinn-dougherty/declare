{ machine, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.virt-manager ];
  users.users.${machine.username}.extraGroups = [ "libvirtd" ];
  virtualisation.libvirtd = {
  enable = true;
  qemu = {
    package = pkgs.qemu_kvm;
    runAsRoot = true;
    swtpm.enable = true;
    ovmf = {
      enable = true;
      packages = [(pkgs.OVMF.override {
        secureBoot = true;
        tpmSupport = true;
      }).fd];
    };
  };
};
}
