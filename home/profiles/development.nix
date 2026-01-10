{ pkgs, ... }:

{
  # Development tools
  home.packages = with pkgs; [
    # Editors
    helix
    neovim
    
    # Version control
    git
    gh          # GitHub CLI
    
    # Container tools
    podman
    podman-compose
    
    # Programming languages
    # python3
    nodejs
    # rustc
    # cargo
    
    # Build tools
    # gnumake
    # cmake
    
    # Database clients
    # sqlite
    # postgresql
  ];

  # Helix editor configuration
  programs.helix = {
    enable = true;
    settings = {
      theme = "onedark";

      editor.true-color = true;

      editor.cursor-shape.insert = "bar";
      editor.cursor-shape.normal = "block";
      editor.cursor-shape.select = "underline";

      editor.file-picker.git-ignore = false;
      editor.file-picker.git-global = false;

      keys.insert.tab = "insert_tab";
    };
  };

  # Git advanced config untuk development
  # programs.git = {
  #   settings = {
  #     core.editor = "hx";
  #     diff.tool = "vimdiff";
  #   };
  # };
}
