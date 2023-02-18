{
  description = "Your new nix config";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";

    # nix user repository
    nur.url = github:nix-community/NUR;

    # home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; }; # Pass flake inputs to our config
        modules = [ ./nixos/configuration.nix ]; # > Our main nixos configuration file <
      };
    };

    homeConfigurations = {
      "svl@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
        modules = [ ./home-manager/home.nix ]; # > Our main home-manager configuration file <
      };
    };
  };
}
