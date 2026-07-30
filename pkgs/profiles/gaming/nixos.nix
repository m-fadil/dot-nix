{ ... }:

{
  # Steam & gamemode butuh modul NixOS-nya, bukan cuma paketnya, karena bagian
  # yang penting hidup di level sistem:
  #
  #   steam    -> udev rules hardware.steam-hardware (Steam Controller, Index)
  #   gamemode -> polkit rules + wrapper CAP_SYS_NICE. Tanpa itu gamemoded tidak
  #               boleh menurunkan niceness atau mengganti CPU governor, jadi
  #               `gamemoderun` jalan tanpa melakukan apa-apa.
  programs.steam = {
    enable = true;

    # Wrapper yang tahu path library Steam; protontricks lepasan sering tidak
    # menemukan prefix Proton.
    protontricks.enable = true;

    # Dibiarkan default (false) supaya konsisten dengan firewall tertutup di
    # ../../system/networking.nix. Nyalakan hanya kalau memang dipakai —
    # masing-masing membuka port:
    #   remotePlay.openFirewall = true;                # UDP 27031-27036, TCP 27036
    #   localNetworkGameTransfers.openFirewall = true; # TCP/UDP 27040
    #   dedicatedServer.openFirewall = true;           # TCP/UDP 27015
  };

  programs.gamemode.enable = true;
}
