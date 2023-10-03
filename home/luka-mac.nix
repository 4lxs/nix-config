{ inputs, outputs, lib, config, pkgs, ... }: {
    imports = [
    ./features/tmux
    ./features/zsh
    ./features/nvim
    ./features/git
    ./features/rust
    ./features/alacritty
    ./features/fonts
    ];

    home = {
        username = "luka";
        homeDirectory = "/Users/luka";
    };



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

  programs = {
    # user program configuration
    exa.enable = true;
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    bat = {
      enable = true;
      config.theme = "TwoDark";
    };
    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };
    zathura = {
      enable = true;
      options = {
        # adjust-open = "best-fit";
        # pages-per-row = 1;

        # scroll-page-aware = true;
        # scroll-step = 100;

        default-bg = "#1a1b26";
        default-fg = "#a9b1d6";

        statusbar-fg = "#a9b1d6";
        statusbar-bg = "#24283b";

        inputbar-bg = "#1a1b26";
        inputbar-fg = "#73daca";

        notification-bg = "#1a1b26";
        notification-fg = "#73daca";

        notification-error-bg = "#1a1b26";
        notification-error-fg = "#f7768e";

        notification-warning-bg = "#1a1b26";
        notification-warning-fg = "#f7768e";

        highlight-color = "#e0af68";
        highlight-active-color = "#9aa5ce";

        completion-bg = "#24283b";
        completion-fg = "#a9b1d6";

        completion-highlight-fg = "#9aa5ce";
        completion-highlight-bg = "24283b";

        recolor-lightcolor = "#16161e";
        recolor-darkcolor = "#a9b1d6";

        recolor = "true";
        # recolor-keephue = "true";

        selection-clipboard = "clipboard";
      };
    };

    home-manager.enable = true;
  };

  # Needed for virtualization
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
