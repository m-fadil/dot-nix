{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [
      # LazyVim dependencies
      git
      gcc
      gnumake
      unzip
      wget
      curl
      ripgrep
      fd
      xclip
      wl-clipboard
      tree-sitter
      nodejs
      
      # LSPs, formatters, and linters can be added here
      lua-language-server
      stylua
    ];
  };
}
