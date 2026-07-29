{ lib, ... }:

{
  options.my = {
    desktop = lib.mkOption {
      type = lib.types.enum [ "hyprland" "plasma" "gnome" ];
      default = "plasma";
      description = "Desktop environment to enable for this host.";
    };

    displayManager = lib.mkOption {
      type = lib.types.enum [ "sddm" "gdm" "none" ];
      default = "sddm";
      description = "Display manager to enable for this host.";
    };
  };

  # Audio stack — sama persis untuk hyprland/plasma/gnome, jadi didefinisikan
  # sekali di sini alih-alih diduplikasi di tiap modul DE.
  config = {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
