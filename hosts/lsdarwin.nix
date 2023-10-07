{ pkgs, ... }: {
  imports = [
    ./features/darwin-keyboard
  ];

  services.nix-daemon.enable = true;
  nix.package = pkgs.nixUnstable;

  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    casks = [
      "brave-browser"
    ];
  };

  users.users."lukas".home = "/Users/lukas/";

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    #
    #    # You can add overlays here
    #    overlays = [
    #      # Add overlays your own flake exports (from overlays and pkgs dir):
    #      outputs.overlays.additions
    #      outputs.overlays.modifications
    #      outputs.overlays.stable-packages
    #
    #      # You can also add overlays exported from other flakes:
    #      # neovim-nightly-overlay.overlays.default
    #
    #      # Or define it inline, for example:
    #      # (final: prev: {
    #      #   hi = final.hello.overrideAttrs (oldAttrs: {
    #      #     patches = [ ./change-hello-to-hi.patch ];
    #      #   });
    #      # })
    #    ];
    config = {
      allowUnfree = true;
    };
  };
  #
  nix = {
    #    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    #    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    #
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
  #
  #  # localization
  #  time.timeZone = "Europe/Ljubljana";
  #
  #  users.defaultUserShell = pkgs.zsh;
  #  environment.shells = [ pkgs.zsh ];
  #  # environment.binsh = "${pkgs.dash}/bin/dash";
  #
  #  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  #  system.stateVersion = "22.11";
}
