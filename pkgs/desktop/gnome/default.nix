{ lib, config, pkgs, ... }:

{
  config = lib.mkIf (config.my.desktop == "gnome") {
    services.xserver.enable = true;

    services.desktopManager.gnome.enable = true;

    services.displayManager.gdm = {
      enable = true;
      wayland.enable = true;
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ intel-media-driver ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ intel-media-driver ];
    };

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    };
  };
}
