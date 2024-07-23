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
    home.packages = with pkgs; [
      inputs.nvim-config.packages.${system}.default

      ripgrep
      fd
      socat
      unzip
      wget
      jq
      htop
      p7zip
    ];

    programs = {
      eza.enable = true;
      zoxide = {
        enable = true;
      };
      bat = {
        enable = true;
        # config.theme = "TwoDark";
      };
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
