{ lib, stdenv, fetchFromGitHub, pkgs ? import <nixpkgs> {}, themeConfig ? { } }:
{
  sugar-dark = stdenv.mkDerivation rec {
    pname = "sddm-sugar-dark-theme";
    version = "1.2";
    # dontBuild = true;
    dontWrapQtApps = true;
    propagatedBuildInputs = [ pkgs.libsForQt5.qt5.qtgraphicaleffects ];
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/sugar-dark
    '';
    postFixup = ''
        mkdir -p $out/nix-support

        echo ${pkgs.libsForQt5.qt5.qtgraphicaleffects} >> $out/nix-support/propagated-user-env-packages
      '';

    src = fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-sugar-dark";
      rev = "v${version}";
      sha256 = "0gx0am7vq1ywaw2rm1p015x90b75ccqxnb1sz3wy8yjl27v82yhb";
    };
  };
}