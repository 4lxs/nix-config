{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
    ./features/tmux
    ./features/zsh
    ./features/nvim
    ./features/fonts
    ./features/git
  ];

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.packages = with pkgs; [
    ripgrep
    fd
    unzip
    wget
  ];

  programs = { # user program configuration
    exa.enable = true; # ls replacement
    zoxide = { # cd replacement
      enable = true;
      enableZshIntegration = true;
    };
    bat = { # cat replacement
      enable = true;
      config.theme = "TwoDark";
    };

    home-manager.enable = true;
  };

  dconf.settings = { # Needed for virtualization
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
