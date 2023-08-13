{
  description = "Svl nixos config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }@inputs:
  let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];
    pkgsFor = nixpkgs.legacyPackages;
  in rec {
    packages = forAllSystems (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in import ./pkgs { inherit pkgs; }
    );
    # Devshell for bootstrapping
    # Acessible through 'nix develop'
    devShells = forAllSystems (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in import ./shell.nix { inherit pkgs; }
    );
    overlays = import ./overlays { inherit inputs; };
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    # 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };

    # 'home-manager switch --flake .#your-username@your-hostname'
    homeConfigurations = {
      "svl@nixos" = lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [ ./home/svl.nix ];
      };
      "lukas@pop-os" = lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [ ./home/lukas.nix ];
      };
    };
  };
}
