{ inputs, lib, config, pkgs, ... }: { # neovim config
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlay
  ];
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
  };
  # xdg.configFile.nvim.source = ./config;
}
