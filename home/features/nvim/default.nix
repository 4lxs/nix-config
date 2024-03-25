{ pkgs, ... }: {
  home.packages = with pkgs; [
    nodePackages_latest.nodejs
    statix
    nixd
    marksman
    markdownlint-cli
    stylua
    lua-language-server
    fswatch
    texliveFull
    biber
    clang-tools_17
  ];
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
  };
  # xdg.configFile.nvim.source = ./config;
}
