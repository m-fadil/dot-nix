{ pkgs, ... }:

{
  # State version
  home.stateVersion = "24.11";

  # Essential packages untuk semua user
  home.packages = with pkgs; [];
}
