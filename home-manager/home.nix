{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    ./hyprland
    ./alacritty
    ./zsh
    ./tmux
    ./fonts
    ./nvim
    ./python
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
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "svl";
    homeDirectory = "/home/svl";
    packages = with pkgs; [ # extra programs
      dash
      socat
      jq
      shfmt
      mpv
      stig
      qbittorrent
    ];
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/go/bin"
    ];
  };

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
    firefox = { # browser
      enable = true;
      # profiles.svl = {
      #   extensions = with config.nur.repos.rycee.firefox-addons; [
      #     bitwarden
      #   ];
      # };
    };
    git = { # version control
      enable = true;
      extraConfig = {
        user.email = "svensek.luka@pm.me";
        user.name = "Svl";
      };
    };
    go.enable = true;
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
    vscode.enable = true;

    home-manager.enable = true;
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "adwaita-dark";
  };

  services.playerctld.enable = true;
  services.blueman-applet.enable = true;
  services.mpris-proxy.enable = true;
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
