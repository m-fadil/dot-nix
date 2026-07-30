{ lib, config, inputs, pkgs, pkgsUnstable, ... }:

{
  imports = [ inputs.silentSDDM.nixosModules.default ];

  config = lib.mkIf (config.my.desktop == "hyprland") {
    # Enable Hyprland
    programs = {
      hyprland = {
        enable = true;
        package = pkgs.hyprland;
        xwayland.enable = true;
      };

      uwsm = {
        enable = true;
        package = pkgsUnstable.uwsm;
      };

      silentSDDM = {
        enable = config.my.displayManager == "sddm";
        theme = "silvia";
      };
    };

    # Display manager
    services.displayManager = {
      defaultSession = "hyprland-uwsm";

      sddm = {
        enable = config.my.displayManager == "sddm";
        wayland.enable = true;
      };
    };

    # Seat management
    services.seatd.enable = true;

    # XDG Portal untuk Wayland
    xdg.portal = {
      enable = true;
      wlr.enable = false;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];

      config.common.default = [
        "hyprland"
        "gtk"
      ];
    };

    security.polkit.enable = true;

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
      bun
      grim
      slurp
      satty
      jq
      thunar
      imv
    ];

    # Session variables
    environment.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      GDK_BACKEND = "wayland,x11";
      NIXOS_OZONE_WL = "1";
      LIBVA_DRIVER_NAME = "iHD";
    };
  };
}
