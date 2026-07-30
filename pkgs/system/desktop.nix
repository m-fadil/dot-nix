{ lib, config, ... }:

{
  options.my = {
    desktop = lib.mkOption {
      type = lib.types.enum [ "hyprland" "plasma" "gnome" ];
      default = "plasma";
      description = "Desktop environment to enable for this host.";
    };

    displayManager = lib.mkOption {
      type = lib.types.enum [ "sddm" "gdm" "none" ];
      default = "sddm";
      description = "Display manager to enable for this host.";
    };

    # Sumbu terpisah dari `desktop`: hyprland hanya compositor, ia tidak
    # membawa bar/launcher/notifikasi sendiri. Plasma & GNOME sudah punya,
    # jadi kombinasi itu ditolak lewat assertion di bawah.
    shell = lib.mkOption {
      type = lib.types.enum [ "dms" "noctalia" "none" ];
      default = "none";
      description = "Wayland shell (bar, launcher, notifications) di atas compositor.";
    };

    # Satu sumbu untuk dua modul: paket & config user di
    # ../profiles/gaming/default.nix, dan programs.steam + programs.gamemode di
    # ../profiles/gaming/nixos.nix. Keduanya harus hidup-mati bersama — Steam
    # yang aktif di level sistem tanpa tooling Wine/Proton di level user (atau
    # sebaliknya) cuma setengah jalan.
    gaming = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Gaming stack: Steam, gamemode, dan tooling Wine/Proton.";
    };
  };

  config = {
    assertions = [
      {
        assertion = config.my.shell != "none" -> config.my.desktop == "hyprland";
        message =
          "my.shell = \"${config.my.shell}\" butuh my.desktop = \"hyprland\", "
          + "bukan \"${config.my.desktop}\" — plasma/gnome sudah punya shell sendiri.";
      }
    ];

    # `my.displayManager` adalah satu-satunya tempat yang menentukan DM. Modul
    # DE tidak boleh menyalakan sddm/gdm sendiri: dua DM aktif sekaligus
    # bentrok, dan kombinasi yang tidak ada cabangnya menghasilkan sistem tanpa
    # login screen tanpa peringatan apa pun.
    services.displayManager = {
      sddm = {
        enable = config.my.displayManager == "sddm";
        wayland.enable = true;
      };

      gdm.enable = config.my.displayManager == "gdm";
    };

    # Audio stack — sama persis untuk hyprland/plasma/gnome, jadi didefinisikan
    # sekali di sini alih-alih diduplikasi di tiap modul DE.
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
