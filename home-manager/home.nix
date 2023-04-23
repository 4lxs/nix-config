{ inputs, lib, config, pkgs, ... }: { # replaces ~/.config/nixpkgs/home.nix
  imports = [ # home-manager modules from other flakes
    ./gnome.nix
    ./zsh.nix
    ./tmux.nix
    ./alacritty.nix
    ./neovim.nix

    inputs.nur.nixosModules.nur
    inputs.nix-colors.homeManagerModule
  ];

  colorScheme = inputs.nix-colors.colorSchemes.dracula;

  nixpkgs = {
    overlays = [ # You can add overlays here
    ];
    config = { # Configure nixpkgs instance
      allowUnfree = true; # Disable if you don't want propriatary packages
      allowUnfreePredicate = (_: true); # Workaround for https://github.com/nix-community/home-manager/issues/2942
    };
  };

  home = {
    username = "svl";
    homeDirectory = "/home/svl";

    packages = with pkgs; [ # extra programs
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
      profiles.svl = {
        extensions = with config.nur.repos.rycee.firefox-addons; [
          bitwarden
        ];
      };
    };
    git = { # version control
      enable = true;
      extraConfig = {
        user.email = "svensek.luka@pm.me";
        user.name = "Svl";
      };
    };
    java.enable = true;
    hexchat = {
      enable = true;
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
  };


  systemd.user.startServices = "sd-switch"; # Nicely reload system units when changing configs
  home.stateVersion = "22.11"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
}
