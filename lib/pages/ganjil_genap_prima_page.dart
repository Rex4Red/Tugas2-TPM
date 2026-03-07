import 'package:flutter/material.dart';

class GanjilGenapPrimaPage extends StatefulWidget {
  const GanjilGenapPrimaPage({super.key});

  @override
  State<GanjilGenapPrimaPage> createState() => _GanjilGenapPrimaPageState();
}

class _GanjilGenapPrimaPageState extends State<GanjilGenapPrimaPage> {
  final _formKey = GlobalKey<FormState>();
  final _bilanganController = TextEditingController();

  bool _showResult = false;
  bool _isGenap = false;
  bool _isPrima = false;
  int _bilangan = 0;

  @override
  void dispose() {
    _bilanganController.dispose();
    super.dispose();
  }

  bool _cekPrima(int n) {
    if (n < 2) return false;
    for (int i = 2; i <= n ~/ 2; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  void _cek() {
    if (!_formKey.currentState!.validate()) return;

    final bilangan = int.parse(_bilanganController.text);

    setState(() {
      _bilangan = bilangan;
      _isGenap = bilangan % 2 == 0;
      _isPrima = _cekPrima(bilangan);
      _showResult = true;
    });
  }

  void _reset() {
    _formKey.currentState?.reset();
    _bilanganController.clear();
    setState(() {
      _showResult = false;
      _isGenap = false;
      _isPrima = false;
      _bilangan = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Ganjil/Genap & Prima'),
        backgroundColor: Colors.purple,
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
                color: Colors.purple,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.filter_list_rounded,
                    size: 48,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Cek Bilangan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ganjil/Genap dan Bilangan Prima',
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
                    // Input Bilangan
                    TextFormField(
                      controller: _bilanganController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Bilangan',
                        hintText: 'Masukkan bilangan bulat',
                        prefixIcon:
                            const Icon(Icons.numbers_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bilangan tidak boleh kosong';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Masukkan bilangan bulat yang valid';
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
                              onPressed: _cek,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Cek',
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
                              color: Colors.purple.withValues(alpha: 0.1),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Hasil Pengecekan',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.purple[700],
                              ),
                            ),
                            const Divider(height: 24),
                            Text(
                              'Bilangan: $_bilangan',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blueGrey[600],
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Ganjil / Genap
                            _buildResultRow(
                              icon: _isGenap
                                  ? Icons.looks_two_outlined
                                  : Icons.looks_one_outlined,
                              label: _isGenap ? 'Genap' : 'Ganjil',
                              color: _isGenap
                                  ? Colors.teal
                                  : Colors.orange,
                            ),
                            const SizedBox(height: 12),

                            // Prima / Bukan Prima
                            _buildResultRow(
                              icon: _isPrima
                                  ? Icons.star_rounded
                                  : Icons.star_border_rounded,
                              label: _isPrima
                                  ? 'Bilangan Prima'
                                  : 'Bukan Bilangan Prima',
                              color: _isPrima
                                  ? Colors.amber[700]!
                                  : Colors.grey,
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

  Widget _buildResultRow({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
