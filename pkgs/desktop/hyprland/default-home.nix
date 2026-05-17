{ lib, osConfig, inputs, pkgs, ... }:

{
  config = lib.mkIf (osConfig.my.desktop == "hyprland") {
    systemd.user.targets.hyprland-session = {
      Unit = {
        Description = "Hyprland Session Target";
        Requires = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
    };

    # Hyprland related packages
    home.packages = with pkgs; [
      waybar
      wofi
      dunst
      swww
      wlogout
      networkmanagerapplet
    ];

    # Use general cursor
    home.pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    home.sessionVariables = {};
  };
}
