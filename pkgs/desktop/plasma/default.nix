{ lib, config, ... }:

{
  config = lib.mkIf (config.my.desktop == "plasma") {
    # Satu baris sudah cukup: modul plasma6 mengurus sendiri xdg.portal
    # (enable, kwallet + portal-kde + portal-gtk, configPackages) dan session
    # package-nya. Display manager diatur di ../../system/desktop.nix.
    services.desktopManager.plasma6.enable = true;
  };
}
