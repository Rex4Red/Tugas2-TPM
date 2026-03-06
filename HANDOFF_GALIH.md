# HANDOFF - Lanjutan untuk Galih (Penjumlahan & Pengurangan)

## ✅ Yang Sudah Dikerjakan (oleh Thalib)

### Setup Project

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
6. **Aritmatik** (`lib/pages/aritmatik_page.dart`) — halaman menu + placeholder
7. **Profile** (`lib/pages/profile_page.dart`) — info user, tombol data kelompok & logout
8. **Data Kelompok** (`lib/pages/data_kelompok_page.dart`) — list anggota dari database

---

## 📋 Yang Harus Dikerjakan Galih

### Task: Halaman Penjumlahan & Pengurangan

Buat halaman untuk operasi **penjumlahan dan pengurangan** angka.

### Langkah-langkah

1. **Buat file baru** `lib/pages/penjumlahan_pengurangan_page.dart`
   - Input: 2 angka (angka 1 dan angka 2)
   - Pilihan operasi: Penjumlahan (+) atau Pengurangan (-)
   - Tombol Hitung
   - Tampilkan hasil

2. **Update `lib/pages/aritmatik_page.dart`**
   - Import halaman baru
   - Ganti `_PlaceholderPage` pada menu "Penjumlahan & Pengurangan" dengan navigasi ke halaman yang baru dibuat

   Cari bagian ini:

   ```dart
   // TODO: Galih - Navigasi ke halaman penjumlahan & pengurangan
   Navigator.push(
     context,
     MaterialPageRoute(
       builder: (_) => const _PlaceholderPage(
         title: 'Penjumlahan & Pengurangan',
         assignedTo: 'Galih',
       ),
     ),
   );
   ```

   Ganti dengan:

   ```dart
   Navigator.push(
     context,
     MaterialPageRoute(
       builder: (_) => const PenjumlahanPenguranganPage(),
     ),
   );
   ```

### Referensi Pattern

Lihat `lib/pages/piramid_page.dart` sebagai contoh pattern — struktur mirip:

- AppBar dengan warna tema
- Input fields dengan `TextFormField` + validasi
- Tombol Hitung & Reset
- Container untuk menampilkan hasil

### Design Convention

- **Warna tema**: `Colors.green` (sudah di-set di menu card)
- **Style**: Minimalist, rounded corners (borderRadius: 12-16)
- **Font**: Default Material, pakai `TextStyle` dengan `fontWeight` dan `color` dari `Colors.blueGrey`

---

## 📋 Setelah Galih Selesai

Buat file `HANDOFF_NOPAL.md` dengan summary yang sama + task untuk Nopal:

- **Nopal**: Ganjil/Genap & Bilangan Prima
- File: `lib/pages/ganjil_genap_prima_page.dart`
- Update: `lib/pages/aritmatik_page.dart` (ganti placeholder `_PlaceholderPage` untuk menu "Ganjil/Genap & Prima")

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
