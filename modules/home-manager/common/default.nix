{ pkgs, lib, host_config, ... }: {
  home = {
    sessionPath = [ "$HOME/.local/bin" ] ++ lib.optionals pkgs.stdenv.isDarwin [
      "/opt/local/bin"
      "/opt/local/sbin"
    ];
    username = "${host_config.user}";
    homeDirectory = "/home/${host_config.user}";
  };

  programs.home-manager.enable = true;

  # Needed for virtualization
  # dconf.settings = {
  #   "org/virt-manager/virt-manager/connections" = {
  #     autoconnect = [ "qemu:///system" ];
  #     uris = [ "qemu:///system" ];
  #   };
  # };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
