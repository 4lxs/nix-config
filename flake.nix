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

    nvim-config.url = "github:4lxs/nvim-config";

    nix-colors.url = "github:misterio77/nix-colors";

    nur.url = "github:nix-community/NUR";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-parts,
      home-manager,
      nix-darwin,
      apple-silicon,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake =
        let
          nixosHomeConfig = user: host: {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${user} = {
                imports = [
                  ./home/features
                  (./home + "/${user}@${host}")
                ];
              };
              extraSpecialArgs = {
                inherit inputs outputs;
                modules = outputs.homeManagerModules;
                host_config = { # ... ignore me
                  inherit user host;
                };
              };
            };
          };
          nixosConfig = user: host: {
            "${host}" = lib.nixosSystem {
              specialArgs = {
                inherit inputs outputs;
                modules = outputs.nixosModules;
                host_config = { # ... ignore me
                  inherit user host;
                };
              };
              modules = [
                ./hosts/${host}/configuration.nix
                ./hosts/${host}/hardware-configuration.nix
                ./hosts/features
                ./nixpkgs
                home-manager.nixosModules.home-manager
                (nixosHomeConfig "${user}" "${host}")
              ];
            };
          };
          standaloneHomeConfig = user: host: system: {
            "${user}@${host}" = lib.homeManagerConfiguration {
              pkgs = nixpkgs.legacyPackages.${system};
              extraSpecialArgs = {
                inherit inputs outputs;
                modules = outputs.homeManagerModules;
                host_config = { # ... ignore me
                  inherit user host;
                };
              };
              modules = [
                (./home + "/${user}@${host}")
                ./home/features
                ./nixpkgs
              ];
            };
          };
          darwinConfig = user: host: {
            "${host}" = nix-darwin.lib.darwinSystem {
              specialArgs = {
                inherit inputs outputs;
                modules = outputs.nixosModules;
                host_config = { # ... ignore me
                  inherit user host;
                };
              };
              modules = [
                ./hosts/${host}/configuration.nix
                ./nixpkgs
                (home-manager.darwinModules.home-manager (nixosHomeConfig "${user}" "${host}"))
              ];
            };
          };
        in
        {
          overlays = import ./overlays { inherit inputs; };
          nixosModules = import ./modules/nixos;
          homeManagerModules = import ./modules/home-manager;

          # 'nixos-rebuild --flake .#your-hostname'
          nixosConfigurations = lib.mkMerge [ (nixosConfig "svl" "mba") ];

          # initialize: nix run nix-darwin -- switch --flake .
          # 'nix-darwin switch --flake .#hostname'
          darwinConfigurations = lib.mkMerge [ (darwinConfig "lukas" "lsdarwin") ];

          # 'home-manager switch --flake .#your-username@your-hostname'
          homeConfigurations = lib.mkMerge [ (standaloneHomeConfig "lukas" "pop-os" "x86_64-linux") ];
        };
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
        "aarch64-linux"
      ];
      perSystem =
        {
          config,
          pkgs,
          system,
          ...
        }:
        {
          packages = pkgs.callPackage ./pkgs { };
          devShells = pkgs.callPackage ./shell.nix { };
          formatter = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
        };
    };
}
