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

    # Graphics/OpenGL
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        intel-media-driver
      ];
    };

    # Sound (PipeWire)
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
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
