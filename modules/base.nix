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
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  # Essential services
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  services.dbus.enable = true;

  # Essential packages
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    vim
    htop
    tree
    unzip
    zip
  ];

  # Allow unfree packages (jika diperlukan)
  nixpkgs.config.allowUnfree = true;
}
