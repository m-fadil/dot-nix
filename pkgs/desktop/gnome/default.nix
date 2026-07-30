{ lib, config, ... }:

{
  config = lib.mkIf (config.my.desktop == "gnome") {
    services.xserver.enable = true;

    # Modul gnome mengurus sendiri xdg.portal (portal-gnome + portal-gtk +
    # configPackages) dan session package-nya. Display manager diatur di
    # ../../system/desktop.nix.
    services.desktopManager.gnome.enable = true;
  };
}
