-- ============================================
-- Supabase Setup SQL untuk Tugas 2 Mobile
-- Jalankan di Supabase SQL Editor
-- ============================================

-- 1. Buat tabel data_kelompok
CREATE TABLE IF NOT EXISTS data_kelompok (
  id BIGSERIAL PRIMARY KEY,
  nim TEXT UNIQUE NOT NULL,
  nama_lengkap TEXT NOT NULL
);

-- 2. Insert data kelompok
INSERT INTO data_kelompok (nim, nama_lengkap) VALUES
  ('123230161', 'MOHAMMAD THALIB AGUS SAPUTRA'),
  ('123230165', 'NOUVAL DITYA MAHESWARA'),
  ('123230194', 'BENEDICTUS ARYANTIO WIDARJATMO'),
  ('123230198', 'GALIH RASYID MAULANA');

-- 3. Buat tabel users
CREATE TABLE IF NOT EXISTS users (
  id BIGSERIAL PRIMARY KEY,
  nim TEXT UNIQUE NOT NULL REFERENCES data_kelompok(nim),
  password TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. Enable Row Level Security
ALTER TABLE data_kelompok ENABLE ROW LEVEL SECURITY;
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- 5. Policy untuk data_kelompok (semua bisa baca)
CREATE POLICY "Allow public read data_kelompok"
  ON data_kelompok
  FOR SELECT
  TO anon, authenticated
  USING (true);

-- 6. Policy untuk users
CREATE POLICY "Allow public read users"
  ON users
  FOR SELECT
  TO anon, authenticated
  USING (true);

CREATE POLICY "Allow public insert users"
  ON users
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);
