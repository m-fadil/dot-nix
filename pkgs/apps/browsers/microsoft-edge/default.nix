{ pkgsUnstable, ... }:

{
  home.packages = [
    (pkgsUnstable.microsoft-edge.override {
      commandLineArgs = [
        "--ozone-platform-hint=auto"
        "--ozone-platform=wayland"
        "--enable-features=UseOzonePlatform"
      ];
    })
  ];
}
