{ inputs, lib, config, ... }: {
  imports = [ inputs.nix-colors.homeManagerModules.default ];

  options = { cfg.nixColors.enable = lib.mkEnableOption "nix colors"; };

  config = {
    colorScheme = lib.mkIf config.cfg.nixColors.enable
      inputs.nix-colors.colorSchemes.gruvbox-dark-hard;
  };
}
