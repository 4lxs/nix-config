{outputs, ...}: {
  imports = [outputs.nixosModules.dotx];

  dotx = {
    config = "dotx";
    user = {
      name = "svl";
      email = "66408983+4lxs@users.noreply.github.com";
    };

    git.enable = true;
    zathura.enable = true;
    tmux = {
      enable = true;
      makeTerminalDefault = true;
    };
    alacritty.enable = true;
    # shell-help.enable = true;
    kdeconnect.enable = true;

    hack.enable = true;
  };

  cfg = {
    nixosHost.enable = true;
    appleSilicon.enable = true;
  };

  xdg.portal = {
    enable = true;
    # extraPortals = []; # TODO: hyprland
  };
  services.flatpak.enable = true;

  # https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-2094933256
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 6 * 1024;
    }
  ];

  # nix = {
  #   buildMachines = [
  #     {
  #       sshUser = "lukas";
  #       hostName = "work";
  #       sshKey = "/root/.ssh/id_ed25519";
  #       systems = ["x86_64-linux" "aarch64-linux"];
  #       protocol = "ssh-ng";
  #       maxJobs = 24;
  #     }
  #   ];
  #   distributedBuilds = true;
  #   # optional, useful when the builder has a faster internet connection than yours
  #   extraOptions = ''
  #     builders-use-substitutes = true
  #   '';
  # };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
