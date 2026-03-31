import 'package:flutter/material.dart';

class HitungUmurPage extends StatefulWidget {
  const HitungUmurPage({super.key});

  @override
  State<HitungUmurPage> createState() => _HitungUmurPageState();
}

class _HitungUmurPageState extends State<HitungUmurPage> {
  DateTime? _tanggalLahir;
  bool _pakaiKabisat = true;

  // Hasil perhitungan
  int _tahun = 0;
  int _bulan = 0;
  int _hari = 0;
  int _jam = 0;
  int _menit = 0;
  bool _sudahHitung = false;

  Future<void> _pilihTanggal() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggalLahir ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Pilih Tanggal Lahir',
      cancelText: 'Batal',
      confirmText: 'Pilih',
    );

    if (picked != null) {
      setState(() {
        _tanggalLahir = picked;
        _hitungUmur();
      });
    }
  }

  void _hitungUmur() {
    if (_tanggalLahir == null) return;

    final now = DateTime.now();

    if (_pakaiKabisat) {
      // Perhitungan NORMAL (dengan kabisat)
      _hitungUmurNormal(now);
    } else {
      // Perhitungan TANPA kabisat (semua tahun = 365 hari)
      _hitungUmurTanpaKabisat(now);
    }

    _sudahHitung = true;
  }

  void _hitungUmurNormal(DateTime now) {
    int tahun = now.year - _tanggalLahir!.year;
    int bulan = now.month - _tanggalLahir!.month;
    int hari = now.day - _tanggalLahir!.day;

    if (hari < 0) {
      bulan--;
      // Ambil jumlah hari di bulan sebelumnya
      final bulanSebelumnya = DateTime(now.year, now.month, 0);
      hari += bulanSebelumnya.day;
    }

    if (bulan < 0) {
      tahun--;
      bulan += 12;
    }

    _tahun = tahun;
    _bulan = bulan;
    _hari = hari;
    _jam = now.hour;
    _menit = now.minute;
  }

  void _hitungUmurTanpaKabisat(DateTime now) {
    // Step 1: Hitung umur normal (kalender) terlebih dahulu
    int tahun = now.year - _tanggalLahir!.year;
    int bulan = now.month - _tanggalLahir!.month;
    int hari = now.day - _tanggalLahir!.day;

    if (hari < 0) {
      bulan--;
      final bulanSebelumnya = DateTime(now.year, now.month, 0);
      hari += bulanSebelumnya.day;
    }

    if (bulan < 0) {
      tahun--;
      bulan += 12;
    }

    // Step 2: Kurangi jumlah hari kabisat (29 Feb) yang telah dilalui
    int jumlahHariKabisat = _hitungHariKabisat(_tanggalLahir!, now);
    hari -= jumlahHariKabisat;

    // Step 3: Normalisasi jika hari menjadi negatif (pinjam dari bulan)
    while (hari < 0) {
      bulan--;
      if (bulan < 0) {
        tahun--;
        bulan += 12;
      }
      // Hitung bulan yang dipinjam (bulan sebelum posisi saat ini)
      // Posisi bulan saat ini relatif terhadap bulan lahir
      int bulanPinjam = _tanggalLahir!.month + bulan;
      while (bulanPinjam > 12) bulanPinjam -= 12;
      while (bulanPinjam < 1) bulanPinjam += 12;
      hari += _hariDalamBulanTanpaKabisat(bulanPinjam);
    }

    _tahun = tahun;
    _bulan = bulan;
    _hari = hari;
    _jam = now.hour;
    _menit = now.minute;
  }

  /// Jumlah hari dalam bulan tanpa kabisat (Feb selalu 28 hari)
  int _hariDalamBulanTanpaKabisat(int bulan) {
    const hariBulan = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return hariBulan[bulan];
  }

  /// Menghitung berapa kali 29 Februari terjadi antara dua tanggal
  int _hitungHariKabisat(DateTime dari, DateTime sampai) {
    int count = 0;
    // Mulai dari tahun kelahiran sampai tahun sekarang
    for (int year = dari.year; year <= sampai.year; year++) {
      if (_isTahunKabisat(year)) {
        final feb29 = DateTime(year, 2, 29);
        // Cek apakah 29 Feb tahun ini jatuh di antara kedua tanggal
        if (feb29.isAfter(dari) && !feb29.isAfter(sampai)) {
          count++;
        }
      }
    }
    return count;
  }

  bool _isTahunKabisat(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  String _formatTanggal(DateTime date) {
    final bulan = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    return '${date.day} ${bulan[date.month]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Hitung Umur'),
        backgroundColor: Colors.pink[600],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Section
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.cake_rounded,
                    size: 48,
                    color: Colors.pink[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Masukkan tanggal lahir untuk\nmenghitung umur secara detail',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: _pilihTanggal,
                      icon: const Icon(Icons.date_range_rounded),
                      label: Text(
                        _tanggalLahir != null
                            ? _formatTanggal(_tanggalLahir!)
                            : 'Pilih Tanggal Lahir',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[600],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Toggle Kabisat
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hitung Tahun Kabisat',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.pink[800],
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                _pakaiKabisat
                                    ? 'Tahun kabisat dihitung (365/366 hari)'
                                    : 'Semua tahun = 365 hari',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.pink[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _pakaiKabisat,
                          activeColor: Colors.pink[600],
                          onChanged: (val) {
                            setState(() {
                              _pakaiKabisat = val;
                              if (_tanggalLahir != null) _hitungUmur();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Results
            if (_sudahHitung) ...[
              // Info kabisat tahun lahir
              if (_tanggalLahir != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: _isTahunKabisat(_tanggalLahir!.year)
                        ? Colors.green[50]
                        : Colors.orange[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _isTahunKabisat(_tanggalLahir!.year)
                            ? Icons.check_circle_rounded
                            : Icons.info_outline_rounded,
                        size: 20,
                        color: _isTahunKabisat(_tanggalLahir!.year)
                            ? Colors.green[700]
                            : Colors.orange[700],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Tahun ${_tanggalLahir!.year} ${_isTahunKabisat(_tanggalLahir!.year) ? "ADALAH" : "BUKAN"} tahun kabisat',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: _isTahunKabisat(_tanggalLahir!.year)
                              ? Colors.green[700]
                              : Colors.orange[700],
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 16),

              // Grid hasil
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.6,
                children: [
                  _buildResultTile('Tahun', '$_tahun', Icons.calendar_today_rounded, Colors.blue),
                  _buildResultTile('Bulan', '$_bulan', Icons.date_range_rounded, Colors.teal),
                  _buildResultTile('Hari', '$_hari', Icons.wb_sunny_rounded, Colors.orange),
                  _buildResultTile('Jam', '$_jam', Icons.access_time_rounded, Colors.purple),
                ],
              ),

              const SizedBox(height: 12),

              // Menit
              _buildResultTile('Menit', '$_menit', Icons.timer_rounded, Colors.red),

              const SizedBox(height: 16),

              // Summary
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pink[600]!, Colors.pink[300]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      'Umur Kamu${!_pakaiKabisat ? " (tanpa kabisat)" : ""}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$_tahun tahun $_bulan bulan $_hari hari',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '$_jam jam $_menit menit',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResultTile(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
              ),
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
