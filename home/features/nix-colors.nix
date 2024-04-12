{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [ inputs.nix-colors.homeManagerModules.default ];

  options = {
    cfg.nixColors.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "nix colors";
    };
    cfg.nixColors.colorScheme = lib.mkOption {
      type = lib.types.str;
      default = "gruvbox-dark-hard";
    };
  };

  config = lib.mkIf config.cfg.nixColors.enable {
    colorScheme = inputs.nix-colors.colorSchemes."${config.cfg.nixColors.colorScheme}";
  };
}
