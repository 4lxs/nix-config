{ inputs, lib, config, pkgs, ... }: {
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlay
  ];
  home.packages = with pkgs; [
    nodejs_20
    stylua
    lua-language-server
    rnix-lsp
    nixd
    nil
    statix
  ];
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
  };
  # xdg.configFile.nvim.source = ./config;
}
