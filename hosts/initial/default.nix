{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/base.nix
    ../../modules/users.nix
    ../../modules/networking.nix
    ../../modules/locale.nix
    ../../modules/hyprland.nix

    ../../profiles/initial.nix
  ];

  networking.hostName = "nixos-initial";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # home-manager.users.fadil = import ../../profiles/home-initial.nix;

  system.stateVersion = "24.11";
}

