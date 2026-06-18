{ inputs, pkgs, ... }:

{
  imports = [
    # Core System/Home
    ../system/home.nix
    
    # Profiles
    ../hardware/laptop/default-home.nix
    ../desktop/gnome/default-home.nix
    ../desktop/hyprland/default-home.nix
    ../desktop/dms/default.nix
    ../desktop/plasma/default-home.nix
    ../profiles/development
    ../profiles/gaming

    # GUI Apps (Categorized)
    ../apps/browsers/google-chrome
    ../apps/browsers/brave
    ../apps/communication/telegram-desktop
    ../apps/communication/vesktop
    ../apps/media/vlc
    ../apps/media/spicetify
    # bitwarden-desktop depends on electron-39.8.10, which is insecure/EOL in nixpkgs 26.05
    # ../apps/productivity/bitwarden
    ../apps/productivity/obsidian
    ../apps/productivity/libreoffice
    
    # Editors
    ../editors/neovim
    ../editors/helix
    ../editors/vim

    # Shell & CLI
    ../shell/zsh
    ../shell/ghostty
    ../shell/fzf
    ../shell/bat
    ../shell/eza
    ../shell/ripgrep
    ../shell/fd
    ../shell/zellij
    ../shell/delta
    ../shell/nload
    ../shell/wget
    ../shell/curl
    ../shell/htop
    ../shell/tree
    ../shell/unzip
    ../shell/zip
    ../shell/p7zip
    ../shell/lsof
    
    # Dev
    ../dev/git
    ../dev/gh
    ../dev/lazygit
    ../dev/nodejs
    ../dev/python3
    ../dev/android-tools
    ../dev/scrcpy
    ../dev/sourcegit
    ../dev/bruno
    ../dev/dbeaver

    # Virtualisation
    ../virt/podman-desktop

    # Networking
    ../apps/networking/openvpn
  ];

  # Personal git config (specific to this user)
  programs.git = {
    settings = {
      user = {
        name = "Fadil";
        email = "fadlz.dev@gmail.com";
      };
    };
  };
}
