{ pkgs, ... }:

{
  home.packages = [
    (pkgs.google-chrome.override {
      commandLineArgs = [
        "--ozone-platform-hint=auto"
        "--ozone-platform=wayland"
        "--enable-features=UseOzonePlatform"
      ];
    })
  ];
}
