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
}
