{ config, ... }:

let
  userHome = config.users.users.fadil.home or "/home/fadil";
in
{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = false;

    daemon.settings = {
      "data-root" = "${userHome}/.local/share/docker";
      "log-driver" = "local";

      dns = [
        "1.1.1.1"
        "8.8.8.8"
      ];
    };
  };
}
