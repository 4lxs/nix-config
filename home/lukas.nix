{ pkgs, ... }: {
  imports = [
    ./features/alacritty
    ./common.nix
  ];

  home = {
    username = "lukas";
    homeDirectory = "/home/lukas";
  };
}
