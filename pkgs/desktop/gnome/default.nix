{ lib, config, ... }:

{
  config = lib.mkIf (config.my.desktop == "gnome") {
    services.xserver.enable = true;

    services.desktopManager.gnome.enable = true;

    services.displayManager.gdm = {
      enable = true;
    };

    xdg.portal = {
      enable = true;
    };
  };
}
