# NixOS Configuration - Stable & Modular

Konfigurasi NixOS yang modular, stable, dan mudah di-maintain dengan support multi-profile.

## 📁 Struktur Direktori

```
.
├── flake.nix                      # Entry point, definisi sistem
├── flake.lock                     # Lock file (auto-generated)
│
├── hosts/                         # Konfigurasi per-machine
│   └── thinkpad/
│       ├── configuration.nix      # Config utama untuk thinkpad
│       └── hardware-configuration.nix  # Auto-generated hardware config
│
├── modules/                       # System-level modules
│   ├── base.nix                   # Base system config
│   ├── users.nix                  # User management
│   ├── networking.nix             # Network config
│   ├── locale.nix                 # Locale & timezone
│   ├── desktop/
│   │   └── hyprland.nix          # Hyprland WM config
│   └── hardware/
│       ├── laptop.nix             # Laptop-specific (TLP, backlight, etc)
│       └── bluetooth.nix          # Bluetooth config
│
└── home/                          # Home Manager configs
    ├── base.nix                   # Base home config untuk semua user
    ├── profiles/                  # Reusable profiles
    │   ├── laptop.nix             # Laptop user config
    │   ├── hyprland.nix           # Hyprland user config
    │   └── development.nix        # Development tools
    └── users/
        └── fadil.nix              # User-specific config
```

## 🚀 Instalasi Fresh Install

### 1. Boot dari USB NixOS

Download ISO dari nixos.org dan boot dari USB.

### 2. Partisi Disk

```bash
# Lihat disk yang tersedia
lsblk

# Partisi disk (contoh untuk /dev/nvme0n1)
sudo parted /dev/nvme0n1 -- mklabel gpt
sudo parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 512MiB
sudo parted /dev/nvme0n1 -- set 1 esp on
sudo parted /dev/nvme0n1 -- mkpart primary 512MiB 100%

# Format partisi
sudo mkfs.fat -F 32 -n boot /dev/nvme0n1p1
sudo mkfs.ext4 -L nixos /dev/nvme0n1p2

# Mount
sudo mount /dev/disk/by-label/nixos /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/boot /mnt/boot
```

### 3. Generate Hardware Config

```bash
sudo nixos-generate-config --root /mnt
```

### 4. Clone/Copy Konfigurasi Ini

```bash
# Clone dari git (jika sudah di git)
cd /mnt/etc/nixos
sudo rm configuration.nix hardware-configuration.nix
sudo git clone <your-repo-url> .

# Atau copy manual
# Copy semua file dari repo ini ke /mnt/etc/nixos/
```

### 5. Sesuaikan Hardware Configuration

```bash
# Backup hardware config yang di-generate
sudo cp /mnt/etc/nixos/hosts/thinkpad/hardware-configuration.nix /tmp/hw-backup.nix

# Copy hardware config hasil generate
sudo cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/hosts/thinkpad/

# Edit jika diperlukan
sudo nano /mnt/etc/nixos/hosts/thinkpad/hardware-configuration.nix
```

### 6. Sesuaikan Konfigurasi Personal

Edit file berikut sesuai kebutuhan:

```bash
# Hostname (jika bukan 'thinkpad')
sudo nano /mnt/etc/nixos/hosts/thinkpad/configuration.nix

# User info
sudo nano /mnt/etc/nixos/home/users/fadil.nix

# Git config
# Ubah email dan username di:
# - home/base.nix
# - home/users/fadil.nix
```

### 7. Install

```bash
sudo nixos-install --flake /mnt/etc/nixos#thinkpad
```

### 8. Set Password & Reboot

```bash
sudo nixos-enter
passwd fadil
exit
reboot
```

## 🔄 Update System

```bash
# Update flake inputs
sudo nix flake update

# Rebuild dan switch
sudo nixos-rebuild switch --flake .#thinkpad

# Atau dengan home-manager
home-manager switch --flake .#fadil@thinkpad
```

## 🎯 Cara Menambah Profile Baru

### Untuk Laptop Baru (Desktop)

1. Copy hardware config:
```bash
sudo nixos-generate-config
sudo cp /etc/nixos/hardware-configuration.nix hosts/desktop/
```

2. Buat configuration.nix:
```bash
# hosts/desktop/configuration.nix
{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/base.nix
    ../../modules/users.nix
    ../../modules/networking.nix
    ../../modules/locale.nix
    ../../modules/desktop/hyprland.nix
    # TIDAK import laptop.nix untuk desktop
    ../../modules/hardware/bluetooth.nix
  ];

  networking.hostName = "desktop";
  system.stateVersion = "24.11";
}
```

3. Tambahkan di flake.nix:
```nix
nixosConfigurations = {
  thinkpad = mkSystem "thinkpad" "fadil";
  desktop = mkSystem "desktop" "fadil";
};
```

### Untuk User Baru

Buat file `home/users/username.nix`:
```nix
{ inputs, pkgs, ... }:
{
  imports = [
    ../base.nix
    ../profiles/hyprland.nix  # sesuaikan profile
  ];
  
  programs.git = {
    userName = "New User";
    userEmail = "user@example.com";
  };
}
```

## 🛠️ Tips & Troubleshooting

### Rollback ke Generasi Sebelumnya

```bash
# Lihat generasi yang tersedia
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Rollback ke generasi tertentu
sudo nix-env --profile /nix/var/nix/profiles/system --switch-generation <number>
sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
```

### Rebuild Tanpa Switch

```bash
# Test build tanpa apply
sudo nixos-rebuild build --flake .#thinkpad

# Test boot tanpa switch default
sudo nixos-rebuild boot --flake .#thinkpad
```

### Garbage Collection

```bash
# Hapus generasi lama
sudo nix-collect-garbage -d

# Optimize store
sudo nix-store --optimise
```

## 📝 Customization

### Menambah/Hapus Module

Edit `hosts/thinkpad/configuration.nix`, tambah/hapus di bagian imports:

```nix
imports = [
  # ...
  ../../modules/hardware/bluetooth.nix  # Hapus jika tidak perlu
  # ../../modules/hardware/nvidia.nix   # Uncomment jika perlu
];
```

### Menambah Package

**System-wide packages**: Edit `modules/base.nix`
**User packages**: Edit `home/users/fadil.nix`
**Profile packages**: Edit `home/profiles/*.nix`

### Ganti Desktop Environment

Buat profile baru di `modules/desktop/` atau ganti import di configuration.nix:

```nix
# Ganti
../../modules/desktop/hyprland.nix
# Dengan
../../modules/desktop/gnome.nix  # (setelah dibuat)
```

## 📚 Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Nix Pills](https://nixos.org/guides/nix-pills/)
- [NixOS Wiki](https://nixos.wiki/)

## 🔒 Security Notes

- SSH password authentication **disabled** by default
- Sudo tanpa password untuk wheel group (ubah di `modules/users.nix` jika perlu lebih secure)
- Firewall enabled
- Gunakan `hashedPassword` daripada plaintext password

## 📄 License

MIT License - Feel free to use and modify!
