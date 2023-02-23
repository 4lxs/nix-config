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

  xdg.configFile.zathura.source = ./zathura;

  home = {
    username = "svl";
    homeDirectory = "/home/svl";

    packages = with pkgs; [ # extra programs
    ];

    sessionPath = [
      "$HOME/.local/bin"
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
    vscode = { # code editor
      enable = true;
      extensions = [
        pkgs.vscode-extensions.vscodevim.vim
      ];
    };
    git = { # version control
      enable = true;
      extraConfig = {
        user.email = "svensek.luka@pm.me";
        user.name = "Svl";
      };
    };
  };


  systemd.user.startServices = "sd-switch"; # Nicely reload system units when changing configs
  home.stateVersion = "22.11"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
}