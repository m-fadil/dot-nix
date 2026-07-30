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

## 🎛️ Knob Utama: opsi `my.*`

Tiga opsi ini dideklarasikan di `pkgs/system/desktop.nix` dan diset per-host di
`hosts/<nama>/configuration.nix`. Modul-modul DE mengecek nilainya lewat
`config.my.*` (level NixOS) atau `osConfig.my.*` (level Home Manager), jadi
semua modul selalu diimpor dan yang aktif ditentukan di sini — bukan dengan
menambah/menghapus baris import.

| Opsi | Nilai | Default | Arti |
|---|---|---|---|
| `my.desktop` | `hyprland` \| `plasma` \| `gnome` | `plasma` | Compositor/DE |
| `my.displayManager` | `sddm` \| `gdm` \| `none` | `sddm` | Login screen |
| `my.shell` | `dms` \| `noctalia` \| `none` | `none` | Bar, launcher, notifikasi |

`my.shell` adalah sumbu **terpisah** dari `my.desktop`, karena hyprland hanya
compositor dan tidak bawa bar/launcher/notifikasi sendiri. Plasma dan GNOME
sudah punya, jadi `my.shell != "none"` dengan desktop selain hyprland ditolak
lewat assertion — bukan didiamkan, supaya salah ketik di `my.desktop` tidak
berujung sesi tanpa bar tanpa keterangan apa pun.

Contoh isi `hosts/thinkpad/configuration.nix`:

```nix
my.desktop = "hyprland";
my.displayManager = "sddm";
my.shell = "dms";        # ganti ke "noctalia" untuk tukar shell
```

Yang dipusatkan (jangan diduplikasi di modul DE): display manager dan audio
stack di `pkgs/system/desktop.nix`, graphics/OpenGL di
`pkgs/hardware/laptop/default.nix`. `xdg.portal` hampir seluruhnya sudah
dikerjakan modul upstream masing-masing DE.

## 🛠️ Tips Maintenance

Untuk mengubah setting salah satu aplikasi, cukup cari kategorinya di `pkgs/`. Misalnya, konfigurasi `helix` ada di `pkgs/editors/helix/default.nix`.

Sebelum `nixos-rebuild switch`, biasakan `nixos-rebuild build --flake .#thinkpad`
lebih dulu. Workflow `.github/workflows/flake.yml` juga meng-eval config setiap
push, jadi kesalahan nama opsi dan assertion yang gagal ketahuan tanpa harus
membangun apa pun.
