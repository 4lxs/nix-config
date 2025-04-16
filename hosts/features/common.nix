# common between all hosts (nixos and nix-darwin)
{
  inputs,
  pkgs,
  ...
}: {
  # environment.etc."channels/nixpkgs".source = inputs.nixpkgs.outPath;
  nix = {
    # nixPath = ["nixpkgs=/etc/channels/nixpkgs" "nixos-config=/etc/nixos/configuration.nix" "/nix/var/nix/profiles/per-user/root/channels"];
    # registry.nixpkgs.flake = inputs.nixpkgs;
    #    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    #    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    #
    settings = {
      experimental-features = "nix-command flakes";
      # may slow down builds. instead, we use nix.optimise.automatic
      # auto-optimise-store = true;
    };
    optimise = {
      automatic = true;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
  boot = {
    supportedFilesystems = ["ntfs"];
    tmp.cleanOnBoot = true;
  };
  documentation.nixos.enable = false;

  # programs.zsh = {
  #   enable = true;
  #   enableCompletion = false;
  # };

  programs.fish = {
    enable = true;
  };

  programs.dconf.enable = true;
  # security.pam.enableSSHAgentAuth = true;
  # programs.ssh.startAgent = true;

  # sound.enable = true;

  environment = {
    shells = [
      pkgs.fish
      pkgs.bash
    ];
    sessionVariables.NIXOS_OZONE_WL = "1";
    # binsh = "${pkgs.dash}/bin/dash";
  };
}
