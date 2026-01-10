{ pkgs, ... }:

{
  # User configuration
  users.users.fadil = {
    isNormalUser = true;
    description = "Fadil";
    extraGroups = [ 
      "wheel"           # sudo access
      "networkmanager"  # network management
      "video"           # video devices
      "audio"           # audio devices
    ];
    shell = pkgs.zsh;
    
    # Set initial password (change after first login!)
    # hashedPassword dapat dibuat dengan: mkpasswd -m sha-512
    # Untuk sementara, password akan diminta saat first boot
  };

  # Enable zsh system-wide
  programs.zsh.enable = true;

  # Sudo tanpa password untuk wheel group
  security.sudo.wheelNeedsPassword = false;
}
