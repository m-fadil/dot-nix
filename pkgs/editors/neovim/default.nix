{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim

    # LazyVim dependencies
    git
    gcc
    gnumake
    unzip
    wget
    curl
    ripgrep
    fd
    fzf
    lazygit
    xclip
    wl-clipboard
    tree-sitter
    nodejs

    # LSPs, formatters, and linters can be added here
    lua-language-server
    stylua
  ];
}
