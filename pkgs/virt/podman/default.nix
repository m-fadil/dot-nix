{ pkgs, ... }:

{
  virtualisation = {
    containers.enable = true;

    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;

      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };

  # tools CLI
  environment.systemPackages = with pkgs; [
    podman
    podman-compose
    # slirp4netns
    # fuse-overlayfs
    # netavark
    # aardvark-dns
  ];
}

