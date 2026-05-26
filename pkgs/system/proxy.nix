{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xray
  ];
}
