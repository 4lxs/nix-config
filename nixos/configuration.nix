{ inputs, lib, config, pkgs, ... }: { # replaces /etc/nixos/configuration.nix
  imports = [ # You can import other NixOS modules here
    # ./users.nix # TODO split up config
    ./vm.nix

    ./hardware-configuration.nix # this should be generated config
  ];

  nixpkgs = {
    overlays = [ # You can add overlays here
    ];
    config.allowUnfree = true; # allow propriatary software
  };

  nix = { # no clue
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    settings = {
      experimental-features = "nix-command flakes"; # Enable flakes and new 'nix' command
      auto-optimise-store = true; # Deduplicate and optimize nix store
    };
  };

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
    };
    # systemd-boot.enable = true;
    grub = { # setup bootloader
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];

  networking = {
    hostName = "nixos"; # net
    networkmanager.enable = true;
  };

  # localization
  time.timeZone = "Europe/Ljubljana";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sl_SI.UTF-8";
    LC_IDENTIFICATION = "sl_SI.UTF-8";
    LC_MEASUREMENT = "sl_SI.UTF-8";
    LC_MONETARY = "sl_SI.UTF-8";
    LC_NAME = "sl_SI.UTF-8";
    LC_NUMERIC = "sl_SI.UTF-8";
    LC_PAPER = "sl_SI.UTF-8";
    LC_TELEPHONE = "sl_SI.UTF-8";
    LC_TIME = "sl_SI.UTF-8";
  };

  users.users.svl = { # user
    initialPassword = "00000"; # you can pass --no-root-passwd to nixos-install
    isNormalUser = true;
    extraGroups = [ # add groups here
      "wheel"
      "docker"
      "networkmanager"
    ];
  };

  environment.variables = {
    EDITOR = "nvim";
  };

  # default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  environment.binsh = "${pkgs.zsh}/bin/zsh";

  # steam
#  programs.steam = {
#    enable = true;
#    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
#    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
#  };

  # gnome
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gnome-terminal
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

  programs.dconf.enable = true;
  programs.gnome-documents.enable = false;
  programs.gnome-terminal.enable = false;

  services = {
    xserver = { # x11 / gnome
      enable = true;
      libinput.enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      excludePackages = [ # don't install nano
        pkgs.xterm
      ];

      layout = "myx"; # keymap
      xkbOptions = "caps:escape_shifted_capslock,ctrl:swap_lalt_lctl";
      extraLayouts.myx = { # define keymap
        description = "svl's custom layout";
        languages = [ "si" ];
        symbolsFile = ./symbols/myx;
      };
    };
    openssh = { # ssh
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
    };
  };
  console.useXkbConfig = true; # console use same layout as xkb

  # auto upgrade system
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  environment.systemPackages = with pkgs; [
    neovim
    alacritty
    home-manager
    pam_mount
    nerdfonts
    ghidra
    mpv
    zip
    unzip
    qbittorrent
    file
    wget
    curl
    gnumake
    gcc
    gdb
    pwndbg
    cmake
    conda
#    prismlauncher-qt5
#    jetbrains.idea-community
    vscode-fhs
    clang-tools
    androidStudioPackages.canary
#    godot_4
  ];

  hardware.pulseaudio.enable = false;
  services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      # jack.enable = true;
    };

  virtualisation.docker.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
