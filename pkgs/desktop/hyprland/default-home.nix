{ lib, osConfig, pkgs, ... }:

let
  # Satu definisi locker untuk dipakai event lock maupun before-sleep.
  #
  # swaylock, bukan hyprlock: PAM-nya sudah disiapkan wayland-session.nix
  # upstream dan ia jalan tanpa file config. Mengganti ke hyprlock berarti
  # menambah security.pam.services.hyprlock DAN menulis input-field di
  # config-nya — hyprlock tanpa input-field menghasilkan layar terkunci yang
  # tidak bisa dibuka.
  #
  # Path store langsung, bukan lib.getExe: swaylock belum tentu punya
  # meta.mainProgram dan getExe throw kalau tidak ada.
  lockCmd = "${pkgs.swaylock}/bin/swaylock -f -c 1e1e2e";
in
{
  config = lib.mkIf (osConfig.my.desktop == "hyprland") {
    # Agent polkit — pasangan wajib security.polkit, yang hanya menjalankan
    # daemon-nya. Tanpa agent tidak ada dialog autentikasi yang muncul dan
    # pkexec (mis. gparted) gagal tanpa pesan. Plasma & GNOME bawa agent
    # sendiri, DMS dan Noctalia tidak.
    services.hyprpolkitagent.enable = true;

    # Idle & lock khusus sesi hyprland — plasma dan gnome punya idle daemon
    # sendiri, jadi keduanya harus tidak saling menimpa.
    #
    # Rantainya: timeout 300s -> `loginctl lock-session` -> logind mengirim
    # signal Lock -> event `lock` di bawah -> swaylock. Artinya apa pun yang
    # memanggil lock-session (tombol lock di shell, lid close) melewati jalur
    # yang sama. Event `lock` harus berisi locker-nya, bukan lock-session lagi.
    #
    # Dibatasi ke shell "none": dms dan noctalia membawa idle manager dan lock
    # screen sendiri, dan keduanya ikut signal Lock dari logind. Kalau jalan
    # bersamaan:
    #   - ext-session-lock-v1 hanya menerima satu klien; yang kedua menerima
    #     `finished` lalu exit ("Failed to lock session" di log swayidle).
    #   - timeout 600 di bawah men-suspend padahal dms mematikan auto-suspend
    #     (acSuspendTimeout = 0), dan jatuh bersamaan dengan DPMS off dms yang
    #     juga di 600.
    # Timeout untuk shell dms: ../dms/settings.nix, kunci {ac,battery}
    # MonitorTimeout / LockTimeout / SuspendTimeout.
    services.swayidle = lib.mkIf (osConfig.my.shell == "none") {
      enable = true;

      events = {
        # Langsung lockCmd, bukan lewat loginctl: swayidle memblokir sampai
        # perintah before-sleep selesai, jadi lock dijamin sudah terpasang
        # sebelum sistem tidur.
        before-sleep = lockCmd;
        lock = lockCmd;
      };

      timeouts = [
        { timeout = 300; command = "loginctl lock-session"; }
        { timeout = 600; command = "systemctl suspend"; }
      ];
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
  };
}
