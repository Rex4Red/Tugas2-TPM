import 'package:flutter/material.dart';
import 'cek_hari_weton_page.dart';
import 'hitung_umur_page.dart';
import 'konversi_hijriah_page.dart';
import 'konversi_saka_page.dart';

class CekTanggalPage extends StatelessWidget {
  const CekTanggalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Cek Tanggal'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Fitur',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey[700],
              ),
            ),
            const SizedBox(height: 16),

            // 1. Cek Hari & Weton
            _buildMenuCard(
              context,
              icon: Icons.calendar_month_rounded,
              title: 'Cek Hari & Weton',
              description: 'Ketahui hari dan pasaran Jawa dari tanggal tertentu',
              color: Colors.deepPurple,
              page: const CekHariWetonPage(),
            ),
            const SizedBox(height: 16),

            // 2. Hitung Umur
            _buildMenuCard(
              context,
              icon: Icons.cake_rounded,
              title: 'Hitung Umur',
              description: 'Hitung umur detail (tahun, bulan, hari, jam, menit)',
              color: Colors.pink[600]!,
              page: const HitungUmurPage(),
            ),
            const SizedBox(height: 16),

            // 3. Konversi Hijriah
            _buildMenuCard(
              context,
              icon: Icons.mosque_rounded,
              title: 'Konversi Hijriah',
              description: 'Konversi tanggal Masehi ke kalender Hijriah',
              color: Colors.green[700]!,
              page: const KonversiHijriahPage(),
            ),
            const SizedBox(height: 16),

            // 4. Konversi Tahun Saka
            _buildMenuCard(
              context,
              icon: Icons.temple_hindu_rounded,
              title: 'Konversi Tahun Saka',
              description: 'Konversi tanggal Masehi ke kalender Saka (India)',
              color: Colors.orange[800]!,
              page: const KonversiSakaPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required Widget page,
  }) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => page),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, size: 28, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
