{pkgs, ...} @ args: {
  imports = [
    ./devshell.nix
    ./pre-commit.nix
  ];

  flake = {
    formatter = pkgs.alejandra;
    overlays = import ./overlays args;
  };

  perSystem = {pkgs, ...}: {
    packages = import ./pkgs args pkgs;
  };
}
