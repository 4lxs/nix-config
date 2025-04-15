{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  options.cfg.shutils = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable better shell utils";
    };
  };

  config = lib.mkIf config.cfg.shutils.enable {
    home = {
      packages = with pkgs; [
        # inputs.nvim-config.packages.${system}.default
        neovim

        ripgrep
        fd
        socat
        unzip
        wget
        jq
        htop
        p7zip
      ];
      sessionVariables = {
        MANPAGER = ''sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'';
      };
    };

    programs = {
      eza.enable = true;
      zoxide = {
        enable = true;
      };
      bat = {
        enable = true;
        config.theme = "Catppuccin Mocha";
        extraPackages = with pkgs.bat-extras; [batman];
      };
      fish.interactiveShellInit = "batman --export-env | source";
      gh = {
        enable = true;
      };
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
