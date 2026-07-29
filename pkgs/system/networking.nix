{ pkgs, ... }:

{
  # Network Manager untuk easy networking
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
  };

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22
      8080
      20170
      20171
      9223
    ];
    # allowedUDPPorts = [ ];
  };

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
