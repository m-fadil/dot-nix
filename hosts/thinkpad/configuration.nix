{ config, pkgs, ... }:

{
  imports = [
    # Hardware configuration (auto-generated)
    ./hardware-configuration.nix

    # Core system modules
    ../../modules/base.nix
    ../../modules/users.nix
    ../../modules/networking.nix
    ../../modules/locale.nix

    # Desktop environment
    ../../modules/desktop/hyprland.nix

    # Hardware specific
    ../../modules/hardware/laptop.nix
    ../../modules/hardware/bluetooth.nix
  ];

  # Hostname
  networking.hostName = "thinkpad";

  # State version (jangan ubah setelah install pertama)
  system.stateVersion = "24.11";
}
