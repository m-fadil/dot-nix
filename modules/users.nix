{ pkgs, ... }:

{
  users.users.fadil = {
    isNormalUser = true;
    description = "fadil";
    extraGroups = [ "wheel" "networkmanager" "video" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  security.sudo.wheelNeedsPassword = false;
}

