# common between all hosts (nixos and nix-darwin)
{ pkgs, ... }: {
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

  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };
  environment.shells = [ pkgs.zsh pkgs.bash ];
  # environment.binsh = "${pkgs.dash}/bin/dash";
}
