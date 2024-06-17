{inputs, ...}: pkgs: {
  materialyoucolor-python = pkgs.callPackage ./materialyoucolor-python.nix {};
  sddm-themes = pkgs.callPackage ./sddm-themes.nix {};
  rofi-blocks = pkgs.callPackage ./rofi-blocks.nix {};

  # aylur's ags package is x86_64-linux only
  asztal = pkgs.callPackage (inputs.aylur + "/ags") {inherit inputs;};
}
