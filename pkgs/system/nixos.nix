{ pkgs, ... }:

{
  # Enable flakes dan nix command
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # Garbage collection otomatis
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Boot loader
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 5; # max 5 generasi di boot menu
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  # Essential services
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      PubkeyAuthentication = "yes";
    };
  };

  services.dbus.enable = true;

  # Kill process when poweroff
  systemd.services."user@".serviceConfig = {
    KillMode = "mixed";
    KillSignal = "SIGKILL";
    TimeoutStopSec = "10s";
  };

  # Fonts
  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      nerd-fonts.jetbrains-mono
    ];

    fontconfig = {
      enable = true;

      defaultFonts = {
        serif = [ "Noto Serif" "DejaVu Serif" ];
        sansSerif = [ "Noto Sans" "DejaVu Sans" ];
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  # System packages (hanya yang benar-benar esensial di level sistem)
  environment.systemPackages = with pkgs; [
    git
    # pinentry-curses
  ];

  # Allow unfree packages (jika diperlukan)
  nixpkgs.config.allowUnfree = true;

  # Enable nix-ld to run dynamically linked executables (required by Neovim's Mason, tree-sitter, etc.)
  programs.nix-ld.enable = true;
}
