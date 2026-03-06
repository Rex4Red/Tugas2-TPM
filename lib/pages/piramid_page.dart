import 'package:flutter/material.dart';

class PiramidPage extends StatefulWidget {
  const PiramidPage({super.key});

  @override
  State<PiramidPage> createState() => _PiramidPageState();
}

class _PiramidPageState extends State<PiramidPage> {
  final _formKey = GlobalKey<FormState>();
  final _alasController = TextEditingController();
  final _tinggiMiringController = TextEditingController();
  final _tinggiController = TextEditingController();

  double? _luasPermukaan;
  double? _volume;
  bool _showResult = false;

  @override
  void dispose() {
    _alasController.dispose();
    _tinggiMiringController.dispose();
    _tinggiController.dispose();
    super.dispose();
  }

  void _hitung() {
    if (!_formKey.currentState!.validate()) return;

    final a = double.parse(_alasController.text);
    final tMiring = double.parse(_tinggiMiringController.text);
    final t = double.parse(_tinggiController.text);

    setState(() {
      // Luas Permukaan Piramid Segi Empat
      // L = a² + 2 × a × t_miring
      _luasPermukaan = (a * a) + (2 * a * tMiring);

      // Volume Piramid
      // V = 1/3 × a² × t
      _volume = (1 / 3) * (a * a) * t;

      _showResult = true;
    });
  }

  void _reset() {
    _formKey.currentState?.reset();
    _alasController.clear();
    _tinggiMiringController.clear();
    _tinggiController.clear();
    setState(() {
      _luasPermukaan = null;
      _volume = null;
      _showResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Luas & Volume Piramid'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.change_history_rounded,
                    size: 48,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Piramid Segi Empat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Hitung luas permukaan dan volume',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Form
            Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Rumus Info
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.indigo.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rumus:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.indigo[700],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'L = a² + 2 × a × t.miring',
                            style: TextStyle(
                              color: Colors.blueGrey[600],
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'V = ⅓ × a² × t',
                            style: TextStyle(
                              color: Colors.blueGrey[600],
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Sisi Alas
                    TextFormField(
                      controller: _alasController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Sisi Alas (a)',
                        hintText: 'Masukkan panjang sisi alas',
                        prefixIcon: const Icon(Icons.straighten),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Sisi alas tidak boleh kosong';
                        }
                        if (double.tryParse(value) == null ||
                            double.parse(value) <= 0) {
                          return 'Masukkan angka positif yang valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Tinggi Sisi Miring
                    TextFormField(
                      controller: _tinggiMiringController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Tinggi Sisi Miring (t.miring)',
                        hintText: 'Masukkan tinggi sisi miring segitiga',
                        prefixIcon: const Icon(Icons.height),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tinggi sisi miring tidak boleh kosong';
                        }
                        if (double.tryParse(value) == null ||
                            double.parse(value) <= 0) {
                          return 'Masukkan angka positif yang valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Tinggi Piramid
                    TextFormField(
                      controller: _tinggiController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Tinggi Piramid (t)',
                        hintText: 'Masukkan tinggi piramid',
                        prefixIcon: const Icon(Icons.vertical_align_top),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tinggi piramid tidak boleh kosong';
                        }
                        if (double.tryParse(value) == null ||
                            double.parse(value) <= 0) {
                          return 'Masukkan angka positif yang valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: OutlinedButton(
                              onPressed: _reset,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey[600],
                                side: BorderSide(color: Colors.grey[400]!),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Reset'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _hitung,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Hitung',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Result
                    if (_showResult) ...[
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.indigo.withValues(alpha: 0.1),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Hasil Perhitungan',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.indigo[700],
                              ),
                            ),
                            const Divider(height: 24),
                            _buildResultRow(
                              'Luas Permukaan',
                              '${_luasPermukaan!.toStringAsFixed(2)} satuan²',
                            ),
                            const SizedBox(height: 12),
                            _buildResultRow(
                              'Volume',
                              '${_volume!.toStringAsFixed(2)} satuan³',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.blueGrey[600],
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.indigo[700],
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
