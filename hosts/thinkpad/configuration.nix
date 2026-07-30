{ inputs, pkgs, ... }:

{
  imports = [
    # Hardware configuration (auto-generated)
    ./hardware-configuration.nix

    # Core system modules
    ../../pkgs/system/desktop.nix
    ../../pkgs/system/nixos.nix
    ../../pkgs/system/users.nix
    ../../pkgs/system/networking.nix
    ../../pkgs/system/proxy.nix
    ../../pkgs/system/locale.nix

    # Desktop environment
    ../../pkgs/desktop/gnome
    ../../pkgs/desktop/hyprland
    ../../pkgs/desktop/plasma

    # Hardware specific
    ../../pkgs/hardware/laptop
    ../../pkgs/hardware/bluetooth

    # Virtualisation
    ../../pkgs/virt/docker
    ../../pkgs/virt/qemu
    ../../pkgs/virt/waydroid

    # Global Package-specific modules (NixOS level)
    ../../pkgs/shell/zellij/nixos.nix
    ../../pkgs/dev/git/nixos.nix
    ../../pkgs/profiles/gaming/nixos.nix
  ];

  # Enable Zsh at system level
  programs.zsh.enable = true;

  my.desktop = "hyprland";
  my.displayManager = "sddm";
  my.shell = "dms"; # ganti ke "noctalia" untuk tukar shell
  my.gaming = false;

  # Kernel linux zen
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Sensors
  boot.kernelModules = [ "thinkpad_acpi" "coretemp" ];

  # i915 HuC firmware loading untuk CometLake-U (Gen 9.5)
  # enable_guc=2: aktifkan HuC firmware (hardware video decoding offload)
  # GuC submission (nilai 1/3) tidak di-support CometLake, jangan dipakai
  boot.extraModprobeConfig = ''
    options i915 enable_guc=2
  '';

  # Hostname
  networking.hostName = "thinkpad";

  # State version
  system.stateVersion = "26.05";
}
