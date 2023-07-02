{ inputs, lib, config, pkgs, ... }: # gnome configuration
let
  material-gtk-theme = with pkgs; stdenv.mkDerivation rec {
    name = "Material-GTK-Themes";

    buildInputs = [
      gnome.gnome-themes-extra
      gtk-engine-murrine
    ];

    src = fetchFromGitHub {
      owner = "Fausto-Korpsvart";
      repo = name;
      rev = "4d828d5d85bff3307a228c837b9f4fa165a7c30a";
      sha256 = "2E+ZRnvqzzS986J0ckrV73J1YqMUodj8bVXVStxcfUg=";
    };

    installPhase = ''
      mkdir -p $out/share/themes
      mv themes/* $out/share/themes
    '';
  };
in {
  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Material-Palenight-BL";
      package = pkgs.palenight-theme;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  home.sessionVariables.GTK_THEME = "Material-Palenight-BL";

  home.packages = with pkgs; [
    material-gtk-theme
  ];
}
