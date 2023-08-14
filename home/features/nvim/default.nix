{ inputs, lib, config, pkgs, ... }: { # neovim config
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlay
  ];
  home.packages = with pkgs; [
    nodejs_20
    stylua
    lua-language-server
  ];
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
  };
  # xdg.configFile.nvim.source = ./config;
}
