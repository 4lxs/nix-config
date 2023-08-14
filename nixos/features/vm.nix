{ config, pkgs, ... }: { # virtualization support
  # TODO: don't use svl when it's supposed to be system-agnostic feature
  users.users.svl.extraGroups = [
    "kvm"
    "libvirtd"
    "qemu-libvirtd"
  ];


  environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
  # environment.etc = {
  #   "ovmf/edk2-x86_64-secure-code.fd" = {
  #     source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-x86_64-secure-code.fd";
  #   };

  #   "ovmf/edk2-i386-vars.fd" = {
  #     source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-i386-vars.fd";
  #     mode = "0644";
  #     user = "libvirtd";
  #   };
  # };


  environment.systemPackages = with pkgs; [
    virt-manager
    # virt-viewer
    spice
    spice-gtk
    spice-protocol
    # win-virtio
    # win-spice
    libguestfs
    guestfs-tools
  ];

  virtualisation = { # virt-manager
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
  programs.dconf.enable = true;
}
