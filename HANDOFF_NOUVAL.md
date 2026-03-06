# HANDOFF - Lanjutan untuk Nouval (Ganjil/Genap & Bilangan Prima)

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
8. **Profile** (`lib/pages/profile_page.dart`) — info user, tombol data kelompok & logout
9. **Data Kelompok** (`lib/pages/data_kelompok_page.dart`) — list anggota dari database

---

## 📋 Yang Harus Dikerjakan Nouval

### Task: Halaman Ganjil/Genap & Bilangan Prima

Buat halaman untuk mengecek apakah suatu bilangan **ganjil/genap** dan apakah termasuk **bilangan prima**.

### Langkah-langkah

1. **Buat file baru** `lib/pages/ganjil_genap_prima_page.dart`
   - Input: 1 angka (bilangan bulat)
   - Tombol Cek
   - Tampilkan hasil:
     - Bilangan tersebut **Ganjil** atau **Genap**
     - Bilangan tersebut **Prima** atau **Bukan Prima**

2. **Update `lib/pages/aritmatik_page.dart`**
   - Import halaman baru
   - Ganti `_PlaceholderPage` pada menu "Ganjil/Genap & Prima" dengan navigasi ke halaman yang baru dibuat

   Cari bagian ini:

   ```dart
   // TODO: Nopal - Navigasi ke halaman ganjil/genap & prima
   Navigator.push(
     context,
     MaterialPageRoute(
       builder: (_) => const _PlaceholderPage(
         title: 'Ganjil/Genap & Prima',
         assignedTo: 'Nopal',
       ),
     ),
   );
   ```

   Ganti dengan:

   ```dart
   Navigator.push(
     context,
     MaterialPageRoute(
       builder: (_) => const GanjilGenapPrimaPage(),
     ),
   );
   ```

### Referensi Pattern

Lihat `lib/pages/penjumlahan_pengurangan_page.dart` atau `lib/pages/piramid_page.dart` sebagai contoh pattern — struktur mirip:

- AppBar dengan warna tema
- Input fields dengan `TextFormField` + validasi
- Tombol Cek & Reset
- Container untuk menampilkan hasil

### Logic Hint

```dart
// Ganjil/Genap
bool isGenap = bilangan % 2 == 0;

// Prima
bool isPrima(int n) {
  if (n < 2) return false;
  for (int i = 2; i <= n ~/ 2; i++) {
    if (n % i == 0) return false;
  }
  return true;
}
```

### Design Convention

- **Warna tema**: `Colors.purple` (sudah di-set di menu card)
- **Style**: Minimalist, rounded corners (borderRadius: 12-16)
- **Font**: Default Material, pakai `TextStyle` dengan `fontWeight` dan `color` dari `Colors.blueGrey`

---

## 📋 Setelah Nouval Selesai

Buat file `HANDOFF_TIOK.md` dengan summary yang sama + task untuk Tiok:

- **Tiok**: Jumlah Total Angka
- File: `lib/pages/jumlah_total_page.dart`
- Update: `lib/pages/aritmatik_page.dart` (ganti placeholder `_PlaceholderPage` untuk menu "Jumlah Total")

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
