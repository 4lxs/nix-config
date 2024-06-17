{modules, ...}: {
  imports = [
    ./common

    ./firefox
    ./gnome.nix
    ./newsboat.nix
    ./rofi
    ./shutils.nix
    ./sops.nix
    ./user-dirs.nix
    ./zsh
  ];
}
