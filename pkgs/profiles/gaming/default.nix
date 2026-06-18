{ pkgs, pkgsUnstable, ... }:

{
  home.packages = with pkgs; [
    # Core gaming platforms
    steam
    protonup-qt               # Tool untuk download GE-Proton

    # Wine runtimes (installer-focused)
    wineWow64Packages.stable  # baseline, paling stabil
    umu-launcher              # Unified Linux Launcher (bridge Proton GE ke non-steam)

    samba
    winetricks                # dependency installer (vcrun, dx, dotnet)
    protontricks              # Steam Proton prefix helper

    # Performance & diagnostics
    gamemode
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

    # Fonts & rendering (WAJIB untuk Wine/Proton GUI)
    freetype
    fontconfig
    dejavu_fonts
    liberation_ttf
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

  # ==============================
  # Gaming-related environment vars
  # ==============================
  home.sessionVariables = {
    # Enable MangoHud globally (override per-game if needed)
    MANGOHUD = "1";

    # Auto-enable GameMode when supported
    GAMEMODE_AUTO = "1";

    # Wayland-first behavior
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland;xcb";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
