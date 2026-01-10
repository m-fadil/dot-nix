{ pkgs, ... }:

{
  # State version
  home.stateVersion = "24.11";

  # Essential packages untuk semua user
  home.packages = with pkgs; [
    # CLI tools
    ripgrep
    fd
    bat
    eza
    fzf
    
    # Archive tools
    unzip
    zip
    p7zip
    
    # Network tools
    wget
    curl
  ];

  # Git configuration
  programs.git = {
    enable = true;

    settings = {
      user.name = "Fadil";
      user.email = "fadlz.dev@gmail.com";
    };
  };
}
