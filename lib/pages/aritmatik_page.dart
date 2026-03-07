import 'package:flutter/material.dart';
import 'package:tugas2_mobile/pages/ganjil_genap_prima_page.dart';
import 'package:tugas2_mobile/pages/penjumlahan_pengurangan_page.dart';

// ============================================================
// HALAMAN ARITMATIK - PLACEHOLDER
// Halaman ini berisi menu untuk fitur aritmatik yang akan
// dikerjakan oleh anggota kelompok lain:
// - Penjumlahan & Pengurangan → Galih
// - Ganjil/Genap & Prima → Nopal
// - Jumlah Total → Tiok
// ============================================================

class AritmatikPage extends StatelessWidget {
  const AritmatikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Aritmatik'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Operasi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey[700],
              ),
            ),
            const SizedBox(height: 20),

            // Menu Penjumlahan & Pengurangan - TODO: Galih
            _buildMenuItem(
              context,
              icon: Icons.add_circle_outline,
              title: 'Penjumlahan & Pengurangan',
              subtitle: 'Operasi penjumlahan dan pengurangan angka',
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PenjumlahanPenguranganPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            // Menu Ganjil/Genap & Prima - TODO: Nopal
            _buildMenuItem(
              context,
              icon: Icons.filter_list_rounded,
              title: 'Ganjil/Genap & Prima',
              subtitle: 'Cek bilangan ganjil, genap, dan prima',
              color: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const GanjilGenapPrimaPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            // Menu Jumlah Total - TODO: Tiok
            _buildMenuItem(
              context,
              icon: Icons.functions_rounded,
              title: 'Jumlah Total',
              subtitle: 'Hitung jumlah total angka dalam input',
              color: Colors.blue,
              onTap: () {
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
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
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
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
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
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman placeholder sementara untuk fitur yang belum diimplementasi
class _PlaceholderPage extends StatelessWidget {
  final String title;
  final String assignedTo;

  const _PlaceholderPage({
    required this.title,
    required this.assignedTo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction_rounded,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Coming Soon',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Akan dikerjakan oleh $assignedTo',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
