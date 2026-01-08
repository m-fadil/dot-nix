{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  services.dbus.enable = true;
  services.seatd.enable = true;

  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [
    wayland
    xdg-utils
    wl-clipboard

    kitty
    foot

    firefox
    chromium

    grim
    slurp
  ];
}

