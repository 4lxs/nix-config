{ inputs, lib, config, pkgs, ... }: { # neovim config
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlay
  ];
  home.packages = with pkgs; [
    neovim-nightly
  ];
  xdg.configFile.nvim.source = ./config;
}