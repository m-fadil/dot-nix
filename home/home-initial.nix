{ pkgs, ... }:

{
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    waybar
    wofi
  ];

  programs.git.enable = true;
}

