{ ... }:

{
  # Network Manager untuk easy networking
  networking.networkmanager = {
    enable = true;
    wifi.powersave = true;
  };

  # Firewall
  networking.firewall = {
    enable = true;
    # allowedTCPPorts = [ 22 ];
    # allowedUDPPorts = [ ];
  };

  # Faster networking
  networking.useDHCP = false;
  networking.interfaces = {
    # Network interfaces akan di-detect otomatis
    # Uncomment jika perlu konfigurasi manual
    # enp0s1.useDHCP = true;
    # wlp2s0.useDHCP = true;
  };
}
