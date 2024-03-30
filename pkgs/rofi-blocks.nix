{
  stdenv,
  fetchFromGitHub,
  autoreconfHook,
  pkg-config,
  rofi-wayland-unwrapped,
  cairo,
  json-glib,
}:
stdenv.mkDerivation rec {
  pname = "rofi-blocks";
  version = "2023-09-27";

  src = fetchFromGitHub {
    owner = "OmarCastro";
    repo = pname;
    rev = "0a2ba561aa9a31586c0bc8203f8836a18a1f664e";
    sha256 = "U955hzd55xiV5XdQ18iUIwNLn2JrvuHsItgUSf6ww58=";
  };

  nativeBuildInputs = [
    autoreconfHook
    pkg-config
  ];

  buildInputs = [
    rofi-wayland-unwrapped
    cairo
    json-glib
  ];

  patches = [
    ./0001-patch-plugindir-to-output.patch
  ];
}
