{
  description = "Svl nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?rev=e9ee548d90ff586a6471b4ae80ae9cfcbceb3420";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";

    # devshell = {
    #   url = "github:numtide/devshell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    apple-silicon.url = "github:tpwrules/nixos-apple-silicon";
    apple-silicon.inputs.nixpkgs.follows = "nixpkgs";

    nvim-config.url = "github:4lxs/nvim-config";
    # nvim-config.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";

    base16.url = "github:SenchoPens/base16.nix";
    base16-kitty = {
      url = "github:kdrag0n/base16-kitty";
      flake = false;
    };

    ags.url = "github:Aylur/ags";
    matugen.url = "github:InioX/matugen";
    astal.url = "github:Aylur/astal";
    aylur.url = "github:Aylur/dotfiles";
    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";
    end4 = {
      url = "github:end-4/dots-hyprland";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-parts,
    home-manager,
    nix-darwin,
    apple-silicon,
    systems,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import systems;
      imports = [./flake-modules];

      flake = let
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
              # modules = outputs.homeManagerModules;
              host_config = {
                # ... ignore me
                inherit user host;
              };
            };
          };
        };
        nixosConfig = user: host: {
          "${host}" = lib.nixosSystem {
            specialArgs = {
              inherit inputs outputs;
              # modules = outputs.nixosModules;
              host_config = {
                # ... ignore me
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
              # modules = outputs.homeManagerModules;
              host_config = {
                # ... ignore me
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
              # modules = outputs.nixosModules;
              host_config = {
                # ... ignore me
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
      in {
        nixosModules.dotx = {
          imports = [
            (flake-parts.lib.importApply ./lib inputs)
            ((import ./dotx/importModules.nix true inputs) "nixos")
            ./dotx/options
          ];
          # TODO: make optional
          home-manager.sharedModules = [
            (flake-parts.lib.importApply ./lib inputs)
            ((import ./dotx/importModules.nix false inputs) "home")
            (import ./dotx/homeImports.nix inputs)
          ];
        };
        homeManagerModules =
          {
            dotx = {
              imports = [
                (flake-parts.lib.importApply ./lib inputs)
                ((import ./dotx/importModules.nix true inputs) "home")
                ./dotx/options
              ];
            };
          }
          // import ./modules/home-manager;

        # 'nixos-rebuild --flake .#your-hostname'
        nixosConfigurations = lib.mkMerge [(nixosConfig "svl" "mba")];

        # initialize: nix run nix-darwin -- switch --flake .
        # 'nix-darwin switch --flake .#hostname'
        darwinConfigurations = lib.mkMerge [(darwinConfig "lukas" "lsdarwin")];

        # 'home-manager switch --flake .#your-username@your-hostname'
        homeConfigurations = lib.mkMerge [(standaloneHomeConfig "lukas" "pop-os" "x86_64-linux")];
      };
    };
}
