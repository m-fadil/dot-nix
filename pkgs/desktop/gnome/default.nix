{ lib, config, pkgsUnstable, ... }:

{
  config = lib.mkIf (config.my.desktop == "gnome") {
    services.xserver.enable = true;

    services.desktopManager.gnome.enable = true;

    services.displayManager.gdm = {
      enable = true;
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgsUnstable; [ intel-media-driver ];
      extraPackages32 = with pkgsUnstable.pkgsi686Linux; [ intel-media-driver ];
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
    };
  };
}
