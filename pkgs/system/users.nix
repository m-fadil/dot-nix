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
      "render"          # GPU render nodes (/dev/dri/renderD*)
      "audio"           # audio devices
      "docker"
      "dialout"
      "plugdev"
    ];
    shell = pkgs.zsh;
    
    # Set initial password (change after first login!)
    # hashedPassword dapat dibuat dengan: mkpasswd -m sha-512
    # Untuk sementara, password akan diminta saat first boot
  };

  users.groups.plugdev = { };

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0e8d", MODE="0660", GROUP="plugdev", TAG+="uaccess"
  '';

  # Sudo dengan password untuk wheel group
  security.sudo.wheelNeedsPassword = true;
}
