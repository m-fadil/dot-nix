{ pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;
  };

  # programs.virt-manager mengurus sendiri programs.dconf.enable dan
  # environment.systemPackages untuk virt-manager.
  programs.virt-manager.enable = true;
}
