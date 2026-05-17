{ lib, ... }:

{
  options.my.desktop = lib.mkOption {
    type = lib.types.enum [ "hyprland" "plasma" "gnome" ];
    default = "plasma";
    description = "Desktop environment to enable for this host.";
  };
}
