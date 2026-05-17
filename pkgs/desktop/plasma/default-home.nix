{ lib, osConfig, pkgs, ... }:

{
  config = lib.mkIf (osConfig.my.desktop == "plasma") {
    home.packages = with pkgs; [ ];

    home.pointerCursor = {
      name = "Breeze";
      package = pkgs.kdePackages.breeze-icons;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    home.sessionVariables = {
      GTK_USE_PORTAL = "1";
    };
  };
}
