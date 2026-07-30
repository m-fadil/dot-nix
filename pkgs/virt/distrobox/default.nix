{ pkgs, ... }:

{
  # Sandbox terisolasi per-distro di atas backend container yang sudah aktif
  # (docker, ../docker) — distrobox tidak butuh daemon atau modul NixOS sendiri.
  home.packages = [
    pkgs.distrobox
  ];
}
