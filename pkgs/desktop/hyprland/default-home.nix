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
      awww
      networkmanagerapplet
    ]
    # Bar/launcher/notifikasi/logout hanya kalau tidak ada shell yang ambil alih.
    # dunst bukan sekadar redundan: paketnya memasang D-Bus activation file untuk
    # org.freedesktop.Notifications, jadi ia bisa ke-autostart dan berebut nama
    # bus itu dengan notification daemon milik dms/noctalia.
    ++ lib.optionals (osConfig.my.shell == "none") [
      waybar
      wofi
      dunst
      wlogout
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
