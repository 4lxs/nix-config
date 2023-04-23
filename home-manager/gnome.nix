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

  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "alacrity.desktop"
        "org.gnome.Nautilus.desktop"
        "virt-manager.desktop"
      ];
    };
    "org/gnome/desktop/peripherals/touchpad" = { # touchpad
      tap-to-click = true;
      natural-scroll = false;
    };
    "org/gnome/desktop/interface" = { # theme
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gnome/desktop/wm/preferences" = { # workspaces
      workspace-names = [ "Main" ];
    };
    "org/gnome/desktop/background" = { # FIXME
      picture-uri = "file:///home/svl/Pictures/wallpapers/background";
      picture-uri-dark = "file:///home/svl/Pictures/wallpapers/background";
    };
    "org/gnome/desktop/screensaver" = { # FIXME
      picture-uri = "file:///home/svl/Pictures/wallpapers/screensaver";
      primary-color = "#3465a4";
      secondary-color = "#000000";
    };
    "org/gnome/shell" = { # extensions
      disable-user-extensions = false;

      enabled-extensions = [ # `gnome-extensions list` for a list
        # "user-theme@gnome-shell-extensions.gcampax.github.com"
        "trayIconsReloaded@selfmade.pl"
        "Vitals@CoreCoding.com"
        "noannoyance@daase.net"
        "tiling-assistant@leleat-on-github"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
      ];
    };
    "org/gnome/desktop/input-sources" = { # keyboard layout
      show-all-sources = true;
      # sources = [ ( [ "xkb" "myx" ] ) ];
      xkb-options = [ "caps:escape_shifted_capslock" "ctrl:swap_lalt_lctl" ];
    };
  };

  home.packages = with pkgs; [
    # gnomeExtensions.user-themes
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.vitals
    gnomeExtensions.noannoyance-2
    gnomeExtensions.tiling-assistant
    gnomeExtensions.gsconnect
    gnome.gnome-tweaks
    material-gtk-theme
  ];
}
