# common between all hosts (nixos and nix-darwin)
{ pkgs, ... }: {
  nix = {
    #    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    #    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    #
    settings = {
      experimental-features = "nix-command flakes";
      # may slow down builds. instead, we use nix.optimise.automatic
      # auto-optimise-store = true;
    };
    optimise = { automatic = true; };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
  boot.tmp.cleanOnBoot = true;

  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };
  environment = {
    shells = [ pkgs.zsh pkgs.bash ];
    sessionVariables.NIXOS_OZONE_WL = "1";
    # binsh = "${pkgs.dash}/bin/dash";
  };
}
