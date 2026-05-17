# Panduan Gaming Stabil di NixOS (Non-Steam)

Untuk menjalankan game luar Steam (GOG, Epic, Standalone) dengan kestabilan maksimal menggunakan **Proton GE** di NixOS, ikuti langkah-langkah berikut:

## 1. Persiapan Tooling
Pastikan Anda sudah me-rebuild konfigurasi NixOS Anda dengan profil gaming yang baru. Profil ini menyertakan:
- **Heroic Games Launcher**: Sangat stabil untuk Epic/GOG.
- **Lutris**: Untuk game standalone lainnya.
- **ProtonUp-Qt**: GUI untuk mendownload GE-Proton.
- **UMU-Launcher**: Bridge yang membuat Proton GE bisa jalan stabil di luar Steam.

## 2. Langkah-Langkah Setup
1. **Download GE-Proton**:
   - Buka aplikasi `ProtonUp-Qt`.
   - Pilih "Add version" -> "GE-Proton" (Versi terbaru).
   - Tunggu sampai selesai (biasanya terinstall di `~/.steam/root/compatibilitytools.d/`).

2. **Gunakan di Heroic Games Launcher**:
   - Tambahkan game atau login ke GOG/Epic.
   - Buka **Settings** game tersebut.
   - Di bagian **Wine Version**, pilih **GE-Proton** yang baru saja di-download.
   - Heroic akan otomatis memanggil `umu-launcher` sehingga game Anda berjalan di dalam "Steam Container" yang stabil.

3. **Gunakan di Lutris**:
   - Tambahkan game ke Lutris.
   - Buka **Runner Options**.
   - Di bagian **Wine Version**, pilih versi **GE-Proton**.
   - Lutris versi terbaru juga sudah terintegrasi dengan `umu` secara default.

## 3. Tips Tambahan
- **Intel iGPU Stability**: Konfigurasi Hyprland Anda sudah dioptimalkan dengan `intel-media-driver` dan `intel-vaapi-driver` untuk decoding video yang stabil.
- **Stuttering**: Jika game terasa patah-patah di awal, itu biasanya kompilasi shader. Menggunakan Proton GE + UMU membantu memitigasi ini lebih baik dibanding Wine standar.
- **MangoHud**: Sudah aktif secara default. Tekan `Shift_L + F12` (atau sesuai config Anda) untuk melihat performa FPS, suhu, dan penggunaan RAM.

---
**Happy Gaming!**
