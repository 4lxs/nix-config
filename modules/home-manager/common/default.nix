{ pkgs, lib, inputs, svl_config, ... }: {
  home = {
    sessionPath = [ "$HOME/.local/bin" ] ++ lib.optionals pkgs.stdenv.isDarwin [
      "/opt/local/bin"
      "/opt/local/sbin"
    ];
    username = "${svl_config.user}";
    homeDirectory = "/home/${svl_config.user}";
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
