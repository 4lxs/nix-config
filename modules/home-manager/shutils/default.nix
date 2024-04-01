{ pkgs, inputs, ... }: {
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
      enableZshIntegration = true;
    };
    bat = {
      enable = true;
      config.theme = "TwoDark";
    };
    gh = { enable = true; };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
