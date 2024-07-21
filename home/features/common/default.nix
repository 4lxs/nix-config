{
  pkgs,
  lib,
  host_config,
  inputs,
  ...
}: {
  imports = [inputs.nur.nixosModules.nur];
  home = {
    sessionPath =
      ["$HOME/.local/bin"]
      ++ lib.optionals pkgs.stdenv.isDarwin [
        "/opt/local/bin"
        "/opt/local/sbin"
      ];
    sessionVariables = {
      EDITOR = "nvim";
    };
    username = "${host_config.user}";
    homeDirectory = "/home/${host_config.user}";
  };

  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "work" = {
        hostname = "192.168.10.125";
        user = "lukas";
      };
      "ultra" = {
        hostname = "svl.aero.usbx.me";
        user = "svl";
      };
    };
  };

  # xdg.mimeApps.enable = true;

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
