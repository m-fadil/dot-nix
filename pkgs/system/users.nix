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
      "libvirtd"       # kelola VM qemu/kvm tanpa root
      "dialout"
      "plugdev"
    ];
    shell = pkgs.zsh;

    # Password saat ini diset manual lewat `passwd`; hash-nya hidup di
    # /etc/shadow dan TIDAK ada di repo ini. Tanpa baris di bawah, install
    # baru akan membuat akun terkunci ("!" di /etc/shadow) — tidak ada
    # prompt password saat first boot.
    #
    # initialHashedPassword hanya dipakai saat user belum ada di /etc/passwd.
    # Di mesin yang sudah jalan baris ini diabaikan total, termasuk kalau
    # hash-nya diganti. Gunakan `hashedPassword` (bukan initial-) hanya jika
    # ingin repo yang menang atas `passwd` setiap rebuild.
    #
    # Generate: mkpasswd -m yescrypt
    initialHashedPassword = "$y$j9T$kPNvFuprTgM/k4drMyZ2B1$L8zEJkLTeHLZ1QLsFjBRNMiVtTBOJ6LCxzO6IPGaXE8";
  };

  users.groups.plugdev = { };

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0e8d", MODE="0660", GROUP="plugdev", TAG+="uaccess"
  '';

  # Sudo dengan password untuk wheel group
  security.sudo.wheelNeedsPassword = true;
}
