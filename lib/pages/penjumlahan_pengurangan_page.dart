import 'package:flutter/material.dart';

class PenjumlahanPenguranganPage extends StatefulWidget {
  const PenjumlahanPenguranganPage({super.key});

  @override
  State<PenjumlahanPenguranganPage> createState() =>
      _PenjumlahanPenguranganPageState();
}

class _PenjumlahanPenguranganPageState
    extends State<PenjumlahanPenguranganPage> {
  final _formKey = GlobalKey<FormState>();
  final _angka1Controller = TextEditingController();
  final _angka2Controller = TextEditingController();

  bool _isPenjumlahan = true; // true = +, false = -
  double? _hasil;
  bool _showResult = false;

  @override
  void dispose() {
    _angka1Controller.dispose();
    _angka2Controller.dispose();
    super.dispose();
  }

  void _hitung() {
    if (!_formKey.currentState!.validate()) return;

    final a = double.parse(_angka1Controller.text);
    final b = double.parse(_angka2Controller.text);

    setState(() {
      _hasil = _isPenjumlahan ? a + b : a - b;
      _showResult = true;
    });
  }

  void _reset() {
    _formKey.currentState?.reset();
    _angka1Controller.clear();
    _angka2Controller.clear();
    setState(() {
      _hasil = null;
      _showResult = false;
      _isPenjumlahan = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Penjumlahan & Pengurangan'),
        backgroundColor: Colors.green,
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
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.calculate_outlined,
                    size: 48,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Kalkulator Aritmatika',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Hitung penjumlahan dan pengurangan',
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
                    // Operation Selector
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.green.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _isPenjumlahan = true),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: _isPenjumlahan
                                      ? Colors.green
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: _isPenjumlahan
                                          ? Colors.white
                                          : Colors.green[700],
                                      size: 20,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Penjumlahan',
                                      style: TextStyle(
                                        color: _isPenjumlahan
                                            ? Colors.white
                                            : Colors.green[700],
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _isPenjumlahan = false),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: !_isPenjumlahan
                                      ? Colors.green
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.remove,
                                      color: !_isPenjumlahan
                                          ? Colors.white
                                          : Colors.green[700],
                                      size: 20,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Pengurangan',
                                      style: TextStyle(
                                        color: !_isPenjumlahan
                                            ? Colors.white
                                            : Colors.green[700],
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Angka 1
                    TextFormField(
                      controller: _angka1Controller,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Angka 1',
                        hintText: 'Masukkan angka pertama',
                        prefixIcon: const Icon(Icons.looks_one_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Angka 1 tidak boleh kosong';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Masukkan angka yang valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Operator Display
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isPenjumlahan ? Icons.add : Icons.remove,
                          color: Colors.green[700],
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Angka 2
                    TextFormField(
                      controller: _angka2Controller,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Angka 2',
                        hintText: 'Masukkan angka kedua',
                        prefixIcon: const Icon(Icons.looks_two_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Angka 2 tidak boleh kosong';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Masukkan angka yang valid';
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
                                backgroundColor: Colors.green,
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
                              color: Colors.green.withValues(alpha: 0.1),
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
                                color: Colors.green[700],
                              ),
                            ),
                            const Divider(height: 24),
                            Text(
                              '${_angka1Controller.text} ${_isPenjumlahan ? '+' : '−'} ${_angka2Controller.text}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blueGrey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '= ${_hasil!.toStringAsFixed(_hasil! == _hasil!.roundToDouble() ? 0 : 2)}',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.green[700],
                              ),
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
}
