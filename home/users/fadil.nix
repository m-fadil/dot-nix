{ inputs, pkgs, ... }:

{
  imports = [
    # Base configuration (wajib)
    ../base.nix
    
    # Profile berdasarkan kebutuhan
    ../profiles/laptop.nix
    ../profiles/hyprland.nix
    ../profiles/development.nix
  ];

  # Personal packages (spesifik untuk user ini)
  home.packages = with pkgs; [
    # Media
    # mpv
    # vlc
    
    # Office
    libreoffice
    
    # Communication
    telegram-desktop
    discord
    
    # Productivity
    obsidian
    
    # Custom tools
    # neofetch
    # btop
  ];

  # Personal git config
  programs.git = {
      settings.user.name = "Fadil";
      settings.user.email = "fadlz.dev@gmail.com";
  };
}
