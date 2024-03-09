{ pkgs, ... }: {
  home.packages = with pkgs; [
    nodejs_20
    stylua
    lua-language-server
    rnix-lsp
    # nixd
    nil
    statix
  ];
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly; # WARN: doesn't work on arm
  };
  # xdg.configFile.nvim.source = ./config;
}
