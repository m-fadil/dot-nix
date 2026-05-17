{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (brave.override {
      commandLineArgs = [
        "--ozone-platform-hint=auto"
        "--ozone-platform=wayland"
        "--gtk-version=4"
        "--ignore-gpu-blocklist"
        "--enable-features=UseOzonePlatform"
        # Bekerja di Wayland seringkali butuh menonaktifkan window decorations bawaan
        "--disable-features=WaylandWindowDecorations"
      ];
    })
  ];
}
