import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class KonversiHijriahPage extends StatefulWidget {
  const KonversiHijriahPage({super.key});

  @override
  State<KonversiHijriahPage> createState() => _KonversiHijriahPageState();
}

class _KonversiHijriahPageState extends State<KonversiHijriahPage> {
  DateTime? _selectedDate;
  HijriCalendar? _hijriDate;

  // Nama bulan Hijriah
  final List<String> _namaBulanHijriah = [
    '', 'Muharram', 'Safar', 'Rabiul Awal', 'Rabiul Akhir',
    'Jumadil Awal', 'Jumadil Akhir', 'Rajab', 'Sya\'ban',
    'Ramadhan', 'Syawal', 'Dzulqaidah', 'Dzulhijjah',
  ];

  Future<void> _pilihTanggal() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1937, 3, 14),
      lastDate: DateTime(2076, 11, 26),
      helpText: 'Pilih Tanggal Masehi',
      cancelText: 'Batal',
      confirmText: 'Pilih',
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _konversiKeHijriah(picked);
      });
    }
  }

  void _konversiKeHijriah(DateTime date) {
    _hijriDate = HijriCalendar.fromDate(date);
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
        title: const Text('Konversi Hijriah'),
        backgroundColor: Colors.green[700],
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
                    color: Colors.green.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.mosque_rounded,
                    size: 48,
                    color: Colors.green[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Konversi tanggal Masehi\nke kalender Hijriah',
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
                        backgroundColor: Colors.green[700],
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
            if (_selectedDate != null && _hijriDate != null) ...[
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
                    color: Colors.green[50],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_downward_rounded,
                    color: Colors.green[700],
                    size: 28,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Tanggal Hijriah
              _buildDateCard(
                title: 'Tanggal Hijriah',
                icon: Icons.mosque_rounded,
                color: Colors.green[700]!,
                day: '${_hijriDate!.hDay}',
                monthYear: '${_namaBulanHijriah[_hijriDate!.hMonth]} ${_hijriDate!.hYear} H',
                extra: null,
              ),

              const SizedBox(height: 16),

              // Full Hijriah result
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green[700]!, Colors.green[400]!],
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
                      '${_hijriDate!.hDay} ${_namaBulanHijriah[_hijriDate!.hMonth]} ${_hijriDate!.hYear} H',
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

              // Info
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline_rounded, size: 20, color: Colors.amber[800]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Konversi menggunakan library Hijri (kalender Umm al-Qura)',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.amber[900],
                        ),
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
