{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    
    # Perbaikan history (agar history tersimpan dan bisa diakses)
    history = {
      size = 10000;
      save = 10000;
      path = "$HOME/.zsh_history";
      share = true; # Share history between sessions
      ignoreDups = true; # Don't record duplicates
      ignoreSpace = true; # Don't record commands starting with space
      expireDuplicatesFirst = true;
    };

    # Konfigurasi Oh My Zsh
    oh-my-zsh = {
      enable = true;
      theme = ""; # Menggunakan powerlevel10k dari plugins
      plugins = [
        "git"
        "sudo"
        "docker"
        "extract"
        "command-not-found"
      ];
    };

    # Plugins tambahan
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    # Inisialisasi tambahan
    initContent = ''
      # Load powerlevel10k config if it exists
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      
      # Bind keys for autosuggestions
      bindkey '^ ' autosuggest-accept

      # Load custom profile
      [[ ! -f ~/.profile ]] || source ~/.profile
    '';

    # Aliases
    shellAliases = {
      la = "eza -a";
      ll = "eza -l";
      lla = "eza -la";
      ls = "eza";
      lt = "eza --tree";
    };
  };
}
