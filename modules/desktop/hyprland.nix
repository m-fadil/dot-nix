{ pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Seat management
  services.seatd.enable = true;

  # Graphics/OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # XDG Portal untuk Wayland
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
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

  # Essential Wayland packages
  environment.systemPackages = with pkgs; [
    # Wayland essentials
    wayland
    wayland-protocols
    wayland-utils
    xdg-utils
    wl-clipboard
    
    # Terminal emulators
    kitty
    foot
    
    # Browsers
    firefox
    # chromium
    
    # Screenshot tools
    grim
    slurp
    
    # File manager
    pkgs.thunar
    
    # Image viewer
    imv
  ];

  # Session variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";  # Hint Electron apps to use Wayland
    WLR_NO_HARDWARE_CURSORS = "1";  # Fix cursor issue di beberapa hardware
  };
}
