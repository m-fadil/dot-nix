{ lib, config, pkgs, ... }:

{
  config = lib.mkIf (config.my.desktop == "plasma") {
    # Enable KDE Plasma
    services.desktopManager.plasma6.enable = true;

    # Display manager
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    # XDG portal
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.kdePackages.xdg-desktop-portal-kde
      ];
    };
  };
}
