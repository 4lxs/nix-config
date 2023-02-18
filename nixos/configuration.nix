{ inputs, lib, config, pkgs, ... }: { # replaces /etc/nixos/configuration.nix
  imports = [ # You can import other NixOS modules here
    # ./users.nix # TODO split up config

    ./hardware-configuration.nix # this should be generated config
  ];

  nixpkgs = {
    overlays = [ # You can add overlays here
     ];
    
    config = { # Configure nixpkgs instance
      allowUnfree = true; # allow propriatary software
    };
  };

  nix = { # no clue
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    settings = {
      experimental-features = "nix-command flakes"; # Enable flakes and new 'nix' command
      auto-optimise-store = true; # Deduplicate and optimize nix store
    };
  };

  boot.loader.grub = { # setup bootloader
    enable = true;
    device = "/dev/vda";
  };

  # gnome
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    gnome-terminal
    gedit
    epiphany
    geary
    evince
    gnome-characters
    totem
    tali
    iagno
    hitori
    atomix
  ]);

  programs.dconf.enable = true;

  services = {
    libinput = true;

    xserver = { # x11 / gnome
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      layout = "myx"; # keymap
      xkbOptions = "caps:escape_shifted_capslock,ctrl:swap_lalt_lctl";
      extraLayouts.custom = { # define keymap
        description = "svl's custom layout";
        languages = [ "si" ];
        symbolsFile = ./symbols/myx;
      };
    };
  };
  console.useXkbConfig = true; # console use same layout as xkb
  networking.hostName = "nixos"; # net

  users.users.svl = { # user
    initialPassword = "00000"; # you can pass --no-root-passwd to nixos-install
    isNormalUser = true;
    extraGroups = [ # add groups here
      "wheel"
      "docker"
      "libvirtd"
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    # zathura
    # virt-manager
    # alacritty
    # gnome.gnome-tweaks
  ];

  # virtualisation.docker.enable = true;

  # virtualisation.libvirtd = { # virt-manager
  #   enable = true;
  # };

  services.openssh = { # ssh
    # enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
