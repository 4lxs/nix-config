{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./common.nix
    ./features/hyprland
    ./features/alacritty
    ./features/python
    ./features/rust
    ./features/hacking
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
      androidStudioPackages.canary
      gcc
    ];
  };

  programs = { # user program configuration
    firefox = { # browser
      enable = true;
      # profiles.svl = {
      #   extensions = with config.nur.repos.rycee.firefox-addons; [
      #     bitwarden
      #   ];
      # };
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
    vscode.enable = true;
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "adwaita-dark";
  };

  services = {
    udiskie.enable = true;
    playerctld.enable = true;
    blueman-applet.enable = true;
    mpris-proxy.enable = true;
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
