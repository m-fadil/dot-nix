{ pkgsUnstable, ... }:

{
  home.packages = with pkgsUnstable; [
    tor-browser
  ];
}
