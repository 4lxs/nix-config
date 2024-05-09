{
  pkgs ? (import ./nixpkgs.nix) { },
}:
{
  # Shell for bootstrapping flake-enabled nix and home-manager
  # You can enter it through 'nix develop' or (legacy) 'nix-shell'
  default = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      nix
      home-manager
      git
      cargo
      nixpkgs-fmt
    ];
  };
  dev = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [ statix nixpkgs-fmt ];
  };
}
