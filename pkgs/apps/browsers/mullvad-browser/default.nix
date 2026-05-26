{ pkgsUnstable, ... }:

{
  home.packages = with pkgsUnstable; [
    mullvad-browser
  ];
}
