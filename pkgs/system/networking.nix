{ pkgs, ... }:

{
  # Network Manager untuk easy networking
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
  };

  # Firewall aktif tanpa port yang dibuka — tapi jangan baca ini sebagai "tidak
  # ada yang bisa dijangkau dari jaringan", karena tidak begitu:
  #
  #   networking.firewall hanya memfilter chain INPUT. Docker (aktif di
  #   ../virt/docker) memasang DNAT di nat/PREROUTING plus ACCEPT di chain
  #   FORWARD, jadi paket ke port yang di-publish tidak pernah menyentuh INPUT.
  #   Setiap `docker run -p 8000:8000` terbuka di SEMUA interface, terlepas dari
  #   baris di bawah.
  #
  # Untuk membatasinya, bind eksplisit saat publish, bukan lewat firewall:
  #   -p 127.0.0.1:8000:8000     hanya lokal
  #   -p 100.x.x.x:8000:8000     hanya tailnet (IP tailscale0 host ini)
  #
  # Outbound dan koneksi Tailscale sendiri tetap jalan normal.
  networking.firewall.enable = true;

  # services.netbird = {
  #   enable = true; # for netbird service & CLI
  #   clients.default.config.DisableDNS = true;
  # };

  services.tailscale.enable = true;

  # DNS Mask
  # services.dnsmasq = {
  #   enable = true;
  #   resolveLocalQueries = true;
  #   settings = {
  #     # Listen only on localhost so it can coexist with NetBird's DNS
  #     # listener on the VPN interface.
  #     listen-address = [ "127.0.0.1" ];
  #     bind-interfaces = true;

  #     address = [ "/.internal/127.0.0.1" ];

  #     server = [
  #       "1.1.1.1"
  #       "8.8.8.8"
  #     ];
  #   };
  # };

  environment.systemPackages = with pkgs; [
    caddy
    nssTools
  ];
}
