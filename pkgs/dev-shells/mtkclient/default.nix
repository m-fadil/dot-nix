{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    python313
    uv
    git
    gcc
    pkg-config
    openssl
    libusb1
    bzip2
    lz4
    xz
    sqlite
    readline
    libffi
    tk
    fuse
    android-tools
  ];

  shellHook = ''
    export SP_FLASHTOOL_DIR=/home/fadil/Projects/lg8n/SP_Flash_Tool_v6.2228_Linux
    export QT_PLUGIN_PATH=$SP_FLASHTOOL_DIR/plugins
    export LD_LIBRARY_PATH=$SP_FLASHTOOL_DIR:$SP_FLASHTOOL_DIR/lib:${pkgs.lib.makeLibraryPath [
      pkgs.libusb1
      pkgs.openssl
      pkgs.fuse
      pkgs.libGL
      pkgs.krb5
      pkgs.glib
      pkgs.fontconfig
      pkgs.freetype
      pkgs.zlib
      pkgs.xorg.libX11
      pkgs.xorg.libXext
      pkgs.xorg.libxcb
      pkgs.xorg.libX11.dev
      pkgs.libxkbcommon
      pkgs.stdenv.cc.cc.lib
      pkgs.dbus
    ]}:$LD_LIBRARY_PATH
  '';
}
