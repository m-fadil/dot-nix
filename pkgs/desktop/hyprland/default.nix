{ lib, config, inputs, pkgs, pkgsUnstable, ... }:

{
  imports = lib.optionals (inputs ? silentSDDM) [
    inputs.silentSDDM.nixosModules.default
  ];

  config = lib.mkIf (config.my.desktop == "hyprland") ({
    # Enable Hyprland
    programs.hyprland = {
      enable = true;
      package = pkgsUnstable.hyprland;
      xwayland.enable = true;
    };

    # Sddm
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    # Seat management
    services.seatd.enable = true;

    # Graphics/OpenGL
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ intel-media-driver ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ intel-media-driver ];
    };

    # XDG Portal untuk Wayland
    xdg.portal = {
      enable = true;
      wlr.enable = false;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
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
      wayland
      wayland-protocols
      wayland-utils
      xdg-utils
      wl-clipboard
      papirus-icon-theme
      qt5.qtwayland
      qt6.qtwayland
      qt6.qtmultimedia
      kitty
      foot
      firefox
      grim
      slurp
      flameshot
      xfce.thunar
      imv
    ];

    # Session variables
    environment.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      GDK_BACKEND = "wayland,x11";
      NIXOS_OZONE_WL = 1;
      LIBVA_DRIVER_NAME = "iHD";
    };
  } // lib.optionalAttrs (inputs ? silentSDDM) {
    programs.silentSDDM = {
      enable = true;
      theme = "silvia";
    };
  });
}
