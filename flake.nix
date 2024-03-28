{
  description = "Svl nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";

    apple-silicon.url = "github:tpwrules/nixos-apple-silicon";
    apple-silicon.inputs.nixpkgs.follows = "nixpkgs";

    hyprlock.url = "github:hyprwm/hyprlock";
    hyprlock.inputs.nixpkgs.follows = "nixpkgs";

    # nvim-config.url = "git+file:///home/svl/Projects/nvim-config";
    nvim-config.url = "github:4lxs/nvim-config";
  };

  outputs = {
    self,
    nixpkgs,
    flake-parts,
    home-manager,
    nix-darwin,
    apple-silicon,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    homeConfig = user: host: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${user} = import (./home + "/${user}@${host}");
        extraSpecialArgs = {inherit inputs outputs;};
      };
    };
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      flake = {
        overlays = import ./overlays {inherit inputs;};
        nixosModules = import ./modules/nixos;
        homeManagerModules = import ./modules/home-manager;

        # 'nixos-rebuild --flake .#your-hostname'
        nixosConfigurations = {
          mba = lib.nixosSystem {
            specialArgs = {inherit inputs outputs;};
            modules = [
              ./common
              ./hosts/mba/configuration.nix
              apple-silicon.nixosModules.apple-silicon-support
              # (home-manager.nixosModules.home-manager
              #   (homeConfig "svl" "mba"))
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.svl = import (./home + "/svl@mba");
                  extraSpecialArgs = {inherit inputs outputs;};
                };
              }
            ];
          };
        };

        # initialize: nix run nix-darwin -- switch --flake .
        # 'nix-darwin switch --flake .#hostname'
        darwinConfigurations = {
          lsdarwin = nix-darwin.lib.darwinSystem {
            specialArgs = {inherit inputs outputs;};
            modules = [
              ./common
              ./hosts/lsdarwin.nix
              # (home-manager.darwinModules.home-manager
              #   (homeConfig "lukas" "lsdarwin"))
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.lukas = import (./home + "/lukas@lsdarwin");
                  extraSpecialArgs = {inherit inputs outputs;};
                };
              }
            ];
          };
        };

        # 'home-manager switch --flake .#your-username@your-hostname'
        homeConfigurations = {
          "lukas@pop-os" = lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = {inherit inputs outputs;};
            modules = [./common ./home/lukas.nix];
          };
        };
      };
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
        "aarch64-linux"
      ];
      perSystem = {
        config,
        pkgs,
        ...
      }: {
        packages = pkgs.callPackage ./pkgs {};
        devShells = pkgs.callPackage ./shell.nix {};
      };
    };
}
