# NixOS Configuration - Categorized & Modular

Konfigurasi NixOS yang modular, dikategorikan secara fungsional untuk maintenance yang lebih mudah.

## 📁 Struktur Direktori

```
.
├── flake.nix                      # Entry point, definisi sistem
├── hosts/                         # Konfigurasi per-machine (NixOS)
│   └── thinkpad/
│       ├── configuration.nix      # Config utama untuk machine ini
│       └── hardware-configuration.nix
│
└── pkgs/                          # Modular configurations
    ├── system/                    # Core OS level configs
    ├── shell/                     # CLI, Zsh, Utilities
    ├── editors/                   # Editors & IDEs
    ├── dev/                       # Language runtimes & dev tools
    ├── apps/                      # GUI applications
    │   ├── browsers/
    │   ├── communication/
    │   ├── media/
    │   ├── productivity/
    │   └── networking/
    ├── desktop/                   # DE/WM config
    ├── hardware/                  # Device specific configs
    ├── virt/                      # Virtualisation & Containers
    ├── profiles/                  # Gaming, development, etc.
    └── users/                     # User-specific entry points
```

## 🎯 Mengapa Struktur Ini?

- **Terorganisir**: Semua aplikasi dikelompokkan berdasarkan fungsinya.
- **Granular**: Setiap aplikasi memiliki folder konfigurasinya sendiri di dalam kategori tersebut.
- **Skalabilitas**: Menambah paket baru semudah membuat folder di kategori yang tepat dan meng-import-nya di `pkgs/users/fadil.nix`.

## 🛠️ Tips Maintenance

Untuk mengubah setting salah satu aplikasi, cukup cari kategorinya di `pkgs/`. Misalnya, konfigurasi `helix` ada di `pkgs/editors/helix/default.nix`.
