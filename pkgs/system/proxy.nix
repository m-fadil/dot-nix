{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    v2ray
  ];
}
