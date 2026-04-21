import 'package:flutter/material.dart';

class KonversiSakaPage extends StatefulWidget {
  const KonversiSakaPage({super.key});

  @override
  State<KonversiSakaPage> createState() => _KonversiSakaPageState();
}

class _KonversiSakaPageState extends State<KonversiSakaPage> {
  DateTime? _selectedDate;
  Map<String, dynamic>? _sakaResult;

  // Nama bulan Saka
  final List<String> _namaBulanSaka = [
    '', 'Chaitra', 'Vaisakha', 'Jyaistha', 'Asadha',
    'Sravana', 'Bhadra', 'Asvina', 'Kartika',
    'Agrahayana', 'Pausha', 'Magha', 'Phalguna',
  ];

  // Cek apakah tahun kabisat (Gregorian)
  bool _isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  // Konversi Masehi ke Saka
  Map<String, dynamic> _konversiKeKalenderSaka(DateTime date) {
    final int year = date.year;
    final bool isLeap = _isLeapYear(year);

    // Tanggal mulai tahun baru Saka (1 Chaitra)
    // Normal: 22 Maret, Kabisat: 21 Maret
    final int startDay = isLeap ? 21 : 22;
    final DateTime sakaNewYear = DateTime(year, 3, startDay);

    // Tentukan tahun Saka
    int sakaYear;
    if (date.isBefore(sakaNewYear)) {
      sakaYear = year - 79;
    } else {
      sakaYear = year - 78;
    }

    // Hitung hari dalam bulan Saka
    // Bulan 1 (Chaitra): 30 hari (31 di kabisat)
    // Bulan 2-6 (Vaisakha-Bhadra): 31 hari
    // Bulan 7-12 (Asvina-Phalguna): 30 hari
    final List<int> hariPerBulan = [
      0, // placeholder index 0
      isLeap ? 31 : 30, // Chaitra
      31, // Vaisakha
      31, // Jyaistha
      31, // Asadha
      31, // Sravana
      31, // Bhadra
      30, // Asvina
      30, // Kartika
      30, // Agrahayana
      30, // Pausha
      30, // Magha
      30, // Phalguna
    ];

    // Tanggal mulai setiap bulan Saka dalam Gregorian
    // Chaitra dimulai 22 Maret (21 di kabisat)
    final List<DateTime> startBulan = [];
    startBulan.add(DateTime(0)); // placeholder index 0

    DateTime current = sakaNewYear;
    if (date.isBefore(sakaNewYear)) {
      // Jika sebelum tahun baru Saka, gunakan tahun sebelumnya
      final bool prevLeap = _isLeapYear(year - 1);
      final int prevStartDay = prevLeap ? 21 : 22;
      current = DateTime(year - 1, 3, prevStartDay);

      // Recalculate hari per bulan untuk tahun sebelumnya
      hariPerBulan[1] = prevLeap ? 31 : 30;
    }

    startBulan.add(current); // Chaitra
    for (int i = 2; i <= 12; i++) {
      current = current.add(Duration(days: hariPerBulan[i - 1]));
      startBulan.add(current);
    }

    // Tentukan bulan dan tanggal Saka
    int sakaBulan = 12;
    int sakaHari = 1;

    for (int i = 12; i >= 1; i--) {
      if (!date.isBefore(startBulan[i])) {
        sakaBulan = i;
        sakaHari = date.difference(startBulan[i]).inDays + 1;
        break;
      }
    }

    return {
      'tahun': sakaYear,
      'bulan': sakaBulan,
      'hari': sakaHari,
      'namaBulan': _namaBulanSaka[sakaBulan],
      'hariPerBulan': hariPerBulan,
    };
  }

  Future<void> _pilihTanggal() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime(2100, 12, 31),
      helpText: 'Pilih Tanggal Masehi',
      cancelText: 'Batal',
      confirmText: 'Pilih',
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _sakaResult = _konversiKeKalenderSaka(picked);
      });
    }
  }

  String _formatTanggalMasehi(DateTime date) {
    final bulan = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    return '${date.day} ${bulan[date.month]} ${date.year}';
  }

  String _getHariMasehi(DateTime date) {
    final hari = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    return hari[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Konversi Tahun Saka'),
        backgroundColor: Colors.orange[800],
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
                    color: Colors.orange.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.temple_hindu_rounded,
                    size: 48,
                    color: Colors.orange[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Konversi tanggal Masehi\nke Kalender Saka (India)',
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
                        _selectedDate != null
                            ? _formatTanggalMasehi(_selectedDate!)
                            : 'Pilih Tanggal Masehi',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[800],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Results
            if (_selectedDate != null && _sakaResult != null) ...[
              // Tanggal Masehi
              _buildDateCard(
                title: 'Tanggal Masehi',
                icon: Icons.calendar_today_rounded,
                color: Colors.blue,
                day: '${_selectedDate!.day}',
                monthYear: _formatTanggalMasehi(_selectedDate!).split(' ').skip(1).join(' '),
                extra: _getHariMasehi(_selectedDate!),
              ),

              const SizedBox(height: 16),

              // Arrow
              Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_downward_rounded,
                    color: Colors.orange[800],
                    size: 28,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Tanggal Saka
              _buildDateCard(
                title: 'Tanggal Saka',
                icon: Icons.temple_hindu_rounded,
                color: Colors.orange[800]!,
                day: '${_sakaResult!['hari']}',
                monthYear: '${_sakaResult!['namaBulan']} ${_sakaResult!['tahun']} SE',
                extra: null,
              ),

              const SizedBox(height: 16),

              // Full result banner
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange[800]!, Colors.orange[400]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      'Hasil Konversi',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_sakaResult!['hari']} ${_sakaResult!['namaBulan']} ${_sakaResult!['tahun']} SE',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_getHariMasehi(_selectedDate!)}, ${_formatTanggalMasehi(_selectedDate!)} M',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Rumus info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline_rounded, size: 18, color: Colors.orange[800]),
                        const SizedBox(width: 8),
                        Text(
                          'Cara Perhitungan',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange[900],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Tahun Saka = Tahun Masehi - ${_selectedDate!.month < 3 || (_selectedDate!.month == 3 && _selectedDate!.day < (_isLeapYear(_selectedDate!.year) ? 21 : 22)) ? '79' : '78'}\n'
                      '• Tahun baru Saka (1 Chaitra) = ${_isLeapYear(_selectedDate!.year) ? '21' : '22'} Maret\n'
                      '• SE = Saka Era',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange[900],
                        height: 1.5,
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

  Widget _buildDateCard({
    required String title,
    required IconData icon,
    required Color color,
    required String day,
    required String monthYear,
    String? extra,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                const SizedBox(height: 4),
                Text(
                  monthYear,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800],
                  ),
                ),
                if (extra != null) ...[
                  const SizedBox(height: 2),
                  Text(extra, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
