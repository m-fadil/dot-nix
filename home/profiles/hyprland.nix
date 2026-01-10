{ inputs, pkgs, ... }:

{
  # Hyprland related packages
  home.packages = with pkgs; [
    waybar
    wofi
    dunst         # Notification daemon
    swww          # Wallpaper daemon
    wlogout       # Logout menu
    networkmanagerapplet
  ];

  # Session variables
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Auto-start Hyprland on tty1
  home.file.".zprofile".text = ''
    if [[ -z $DISPLAY && $(tty) == /dev/tty1 ]]; then
      exec start-hyprland
    fi
  '';
}
