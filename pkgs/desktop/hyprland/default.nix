{ lib, config, inputs, pkgs, ... }:

{
  imports = [ inputs.silentSDDM.nixosModules.default ];

  config = lib.mkIf (config.my.desktop == "hyprland") {
    # Enable Hyprland
    programs = {
      hyprland = {
        enable = true;
        package = pkgs.hyprland;
        xwayland.enable = true;

        # uwsm mengikat Hyprland ke graphical-session-pre/graphical-session/
        # xdg-desktop-autostart.target. Jangan setel `programs.uwsm.package`
        # untuk menukar versinya — sesi hyprland-uwsm datang dari paket
        # pkgs.hyprland dan path uwsm di dalamnya sudah dibakar ke Exec=.
        withUWSM = true;
      };

      silentSDDM = {
        enable = config.my.displayManager == "sddm";
        theme = "silvia";
      };
    };

    # Nama sesi valid berasal dari providedSessions paket hyprland: "hyprland"
    # dan "hyprland-uwsm". sddm/gdm sendiri diatur di ../../system/desktop.nix.
    services.displayManager.defaultSession = "hyprland-uwsm";

    # Urutan preferensi backend portal. Sisanya sudah diurus programs.hyprland
    # lewat wayland-session.nix: xdg.portal.enable, extraPortals (termasuk
    # portal-gtk), configPackages, wlr.enable, dan security.polkit.enable.
    xdg.portal.config.common.default = [
      "hyprland"
      "gtk"
    ];

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
