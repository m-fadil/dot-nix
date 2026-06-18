{ pkgs, ... }:

{
  # State version
  home.stateVersion = "26.05";

  # Essential packages untuk semua user
  home.packages = with pkgs; [];
}
