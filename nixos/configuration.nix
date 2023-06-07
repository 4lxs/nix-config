# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      # Import your home-manager configuration
      svl = import ../home-manager;
    };
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

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
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  # FIXME: Add the rest of your current configuration

  # TODO: Set your hostname
  networking.hostName = "nixos";

  # TODO: This is just an example, be sure to use whatever bootloader you prefer
  boot.loader.systemd-boot.enable = true;

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # FIXME: Replace with your username
    svl = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "00000";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCnVuvpmyzQUSbALOxH0t9AmUJWQCOIfyWoYEcPLymcQ6hzleGqx3GAekAnsQmZ0j7r+oPlMnlbgKlpmbrXLaomC+C2V1V1BpobKjLqmXKtsiY5+Jdrn1Fa6vVjzHSrqKfSCWsqOT1aMbFRbWiqoM84usTXA6jH9tiKKnLOnKS6mzpqkjSwr0Rx1QKSS9QeWunzCHdAq0M1aDCbj74nT1F/CBqOgDTQBAbTq3t+nFc083uuwH+dwtxSMkM0ZTD+4yuz8sPar3mC2QDOrG+W90AYP98sJr0uJIqmglrYRs2S/3icX2oMscz8+cjJyeHdd7fnQsr2/EEynh/7nn6av+nLpi8PLquNtgjz4JIz99ONRUShKeUZqALQnGJdHv71rVJ3BE0B4SaKY3wPwFtMcqo9Mns1EEAwEtwKS1RXWIlbJ/fSZPlL5kafc4Ay3se1wN/gQQe7KSQQUB35HsNzbfEdb1+XLSkfsZFDUii/bO2Rup8ME7wroeORA6StIq+zS1U= svl@nixos"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFNjrgWpwJQ7oZjH/jtYa69gntOeswlNCegJg9w4u++b svensek.luka@pm.me"
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "wheel" ];
    };
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = false;
    # Forbid root login through SSH.
    permitRootLogin = "no";
    # Use keys only. Remove if you want to SSH using password (not recommended)
    passwordAuthentication = false;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
