{ pkgs, ... }:

{
  # steam, protontricks, dan gamemode ada di ./nixos.nix, bukan di sini —
  # ketiganya butuh modul NixOS-nya. Alasannya ada di file itu.
  home.packages = with pkgs; [
    # Core gaming platforms
    protonup-qt               # Tool untuk download GE-Proton

    # Wine runtimes (installer-focused)
    wineWow64Packages.stable  # baseline, paling stabil
    umu-launcher              # Unified Linux Launcher (bridge Proton GE ke non-steam)

    samba
    winetricks                # dependency installer (vcrun, dx, dotnet)

    # Performance & diagnostics
    mangohud
    goverlay

    # ISO & legacy installer helpers
    p7zip
    unrar
    cabextract
    file
    aria2

    # Vulkan / OpenGL sanity tools
    vulkan-tools
    mesa-demos

    # Input & controllers
    antimicrox

    # Font Wine/Proton tempatnya di fonts.packages (../../system/nixos.nix)
    # supaya terdaftar di fontconfig sistem. freetype/fontconfig di
    # home.packages tidak berpengaruh apa-apa untuk rendering Wine.
  ];

  # ==============================
  # MangoHud configuration
  # ==============================
  programs.mangohud = {
    enable = true;

    settings = {
      fps = true;
      frametime = true;
      cpu_stats = true;
      gpu_stats = true;
      ram = true;
      vram = true;
      cpu_temp = true;
      gpu_temp = true;

      position = "top-right";
      font_size = 24;
      background_alpha = 0.4;
    };
  };

  # Profil ini sengaja tidak menyetel home.sessionVariables. Yang menggoda untuk
  # ditambahkan tapi jangan:
  #
  #   MANGOHUD=1       masuk ke SETIAP aplikasi Vulkan/GL, bukan cuma game.
  #                    Pakai `mangohud <cmd>` atau launch option Steam per game.
  #   GAMEMODE_AUTO=1  tidak ada yang membacanya; gamemode aktif per-proses
  #                    lewat `gamemoderun`.
  #   SDL_VIDEODRIVER  memaksa wayland global merusak banyak game SDL2 di Proton.
  #
  # QT_QPA_PLATFORM & MOZ_ENABLE_WAYLAND sudah diset sistem-wide di
  # ../../desktop/hyprland/default.nix; versi home.sessionVariables akan
  # menimpanya dan bocor ke sesi plasma/gnome juga.
}
