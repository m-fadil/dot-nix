{ lib, osConfig, pkgs, ... }:

{
  config = lib.mkIf (osConfig.my.desktop == "gnome") {
    home.pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    home.sessionVariables = {
      GTK_USE_PORTAL = "1";
    };
  };
}
