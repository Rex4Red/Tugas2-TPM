# HANDOFF - Lanjutan untuk Tiok (Jumlah Total Angka)

## ✅ Yang Sudah Dikerjakan

### Setup Project (oleh Thalib)

- Flutter project diinisialisasi dengan nama `tugas2_mobile`
- Dependencies: `supabase_flutter`, `crypto`, `shared_preferences`
- Supabase config di `lib/config/supabase_config.dart`

### Database (Supabase)

- SQL setup di `supabase_setup.sql` (tinggal jalankan di Supabase SQL Editor)
- Tabel `data_kelompok` (nim, nama_lengkap) — 4 anggota
- Tabel `users` (nim, password dengan SHA-256 hash)
- RLS policies sudah dikonfigurasi

### Fitur yang Sudah Selesai

1. **Login** (`lib/pages/login_page.dart`) — login dengan NIM & password
2. **Register** (`lib/pages/register_page.dart`) — daftar dengan validasi NIM dari data_kelompok
3. **Home** (`lib/pages/home_page.dart`) — menu utama dengan grid cards + bottom nav
4. **Stopwatch** (`lib/pages/stopwatch_page.dart`) — start/stop/reset/lap
5. **Luas & Volume Piramid** (`lib/pages/piramid_page.dart`) — kalkulator piramid segi empat
6. **Aritmatik** (`lib/pages/aritmatik_page.dart`) — halaman menu aritmatik
7. **Penjumlahan & Pengurangan** (`lib/pages/penjumlahan_pengurangan_page.dart`) — kalkulator penjumlahan dan pengurangan (oleh Galih)
8. **Ganjil/Genap & Prima** (`lib/pages/ganjil_genap_prima_page.dart`) — cek bilangan ganjil/genap dan prima (oleh Nouval)
9. **Profile** (`lib/pages/profile_page.dart`) — info user, tombol data kelompok & logout
10. **Data Kelompok** (`lib/pages/data_kelompok_page.dart`) — list anggota dari database

---

## 📋 Yang Harus Dikerjakan Tiok

### Task: Halaman Jumlah Total Angka

Buat halaman untuk menghitung **jumlah total** dari beberapa angka yang diinputkan user.

### Langkah-langkah

1. **Buat file baru** `lib/pages/jumlah_total_page.dart`
   - Input: beberapa angka (pisahkan dengan koma, misal: `1, 5, 10, 3`)
   - Tombol Hitung
   - Tampilkan hasil:
     - Daftar angka yang diinputkan
     - **Jumlah total** dari semua angka

2. **Update `lib/pages/aritmatik_page.dart`**
   - Import halaman baru
   - Ganti `_PlaceholderPage` pada menu "Jumlah Total" dengan navigasi ke halaman yang baru dibuat

   Cari bagian ini:

   ```dart
   // TODO: Tiok - Navigasi ke halaman jumlah total
   Navigator.push(
     context,
     MaterialPageRoute(
       builder: (_) => const _PlaceholderPage(
         title: 'Jumlah Total',
         assignedTo: 'Tiok',
       ),
     ),
   );
   ```

   Ganti dengan:

   ```dart
   Navigator.push(
     context,
     MaterialPageRoute(
       builder: (_) => const JumlahTotalPage(),
     ),
   );
   ```

   Tambahkan import di bagian atas file:

   ```dart
   import 'package:tugas2_mobile/pages/jumlah_total_page.dart';
   ```

3. **Setelah semua placeholder terganti**, class `_PlaceholderPage` di `aritmatik_page.dart` bisa dihapus karena tidak dipakai lagi.

### Referensi Pattern

Lihat `lib/pages/penjumlahan_pengurangan_page.dart` atau `lib/pages/ganjil_genap_prima_page.dart` sebagai contoh pattern — struktur mirip:

- AppBar dengan warna tema
- Input fields dengan `TextFormField` + validasi
- Tombol Hitung & Reset
- Container untuk menampilkan hasil

### Logic Hint

```dart
// Parse input "1, 5, 10, 3" menjadi list
List<double> parseAngka(String input) {
  return input
      .split(',')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .map((e) => double.parse(e))
      .toList();
}

// Hitung jumlah total
double jumlahTotal = angkaList.reduce((a, b) => a + b);
```

### Design Convention

- **Warna tema**: `Colors.blue` (sudah di-set di menu card)
- **Style**: Minimalist, rounded corners (borderRadius: 12-16)
- **Font**: Default Material, pakai `TextStyle` dengan `fontWeight` dan `color` dari `Colors.blueGrey`

---

## 🔧 Cara Menjalankan Project

```bash
# Install dependencies
flutter pub get

# Jalankan
flutter run

# Analyze (cek error)
flutter analyze
```

## ⚠️ PENTING

- **Supabase Anon Key** harus diisi di `lib/config/supabase_config.dart` (ganti `YOUR_ANON_KEY_HERE`)
- **SQL Setup** harus dijalankan di Supabase SQL Editor terlebih dahulu (`supabase_setup.sql`)
- Pastikan `flutter analyze` tetap **0 issues** setelah perubahan
- Gunakan `.withValues(alpha: X)` bukan `.withOpacity(X)` untuk warna transparan
- Setelah Tiok selesai, class `_PlaceholderPage` bisa dihapus sepenuhnya dari `aritmatik_page.dart`
