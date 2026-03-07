import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingleSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    
    // 1. Ganti semua spasi beruntun (2 atau lebih) menjadi 1 spasi saja
    // 2. Cegah spasi di awal input agar lebih rapi
    String formatted = newValue.text.replaceAll(RegExp(r'\s+'), ' ');
    if (formatted.startsWith(' ')) {
      formatted = formatted.trimLeft();
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class JumlahTotalPage extends StatefulWidget {
  const JumlahTotalPage({super.key});

  @override
  State<JumlahTotalPage> createState() => _JumlahTotalPageState();
}

class _JumlahTotalPageState extends State<JumlahTotalPage> {
  final _formKey = GlobalKey<FormState>();
  final _inputController = TextEditingController();

  List<double> _angkaList = [];
  double _total = 0;
  bool _showResult = false;

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  // Logic Hint Integration
  void _hitung() {
    if (!_formKey.currentState!.validate()) return;

    final input = _inputController.text;
    
    try {
      final parsedList = input
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .map((e) => double.parse(e))
          .toList();

      setState(() {
        _angkaList = parsedList;
        _total = _angkaList.isEmpty ? 0 : _angkaList.reduce((a, b) => a + b);
        _showResult = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Format input salah. Gunakan angka dan koma.')),
      );
    }
  }

  void _reset() {
    _formKey.currentState?.reset();
    _inputController.clear();
    setState(() {
      _angkaList = [];
      _total = 0;
      _showResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Jumlah Total'),
        backgroundColor: Colors.blue,
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
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.summarize_outlined,
                    size: 48,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Total Accumulator',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Hitung jumlah keseluruhan dari daftar angka',
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
                    TextFormField(
                      controller: _inputController,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9,.\s-]')), 
                        SingleSpaceFormatter(), // Pakai yang baru ini
                      ],
                      decoration: InputDecoration(
                        labelText: 'Daftar Angka',
                        hintText: 'Contoh: 1,5 atau 1, 5',
                        prefixIcon: const Icon(Icons.list_alt_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        helperText: 'Otomatis: Koma akan diikuti satu spasi',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Input tidak boleh kosong';
                        }

                        // 1. Cek spasi sebelum koma (Kasus Screenshot 2: "1 , 5")
                        if (value.contains(RegExp(r'\s,'))) {
                          return 'Tidak boleh ada spasi sebelum tanda koma';
                        }

                        // 2. Cek koma beruntun atau ganda (Kasus Screenshot 1: "1 , , 6")
                        if (value.contains(RegExp(r',\s*,'))) {
                          return 'Format salah (ditemukan koma ganda)';
                        }

                        // 3. Cek jika input diawali atau diakhiri dengan koma
                        final trimmedValue = value.trim();
                        if (trimmedValue.startsWith(',') || trimmedValue.endsWith(',')) {
                          return 'Input tidak boleh diawali atau diakhiri koma';
                        }

                        // 4. Validasi karakter ilegal
                        final illegalChars = value.replaceAll(RegExp(r'[0-9,.\s-]'), '');
                        if (illegalChars.isNotEmpty) {
                          return 'Hanya boleh memasukkan angka dan koma';
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
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Hitung Total',
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

                    // Result Display
                    // Result Display
if (_showResult) ...[
  Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.1),
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
            color: Colors.blue[700],
          ),
        ),
        const Divider(height: 24),
        
        const Text(
          'Daftar Angka:',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        const SizedBox(height: 4),
        // Menghilangkan .0 pada daftar angka yang tampil
        Text(
          _angkaList.map((n) => n % 1 == 0 ? n.toInt().toString() : n.toString()).join(' + '),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.blueGrey[600],
          ),
        ),
        const SizedBox(height: 16),
        
        const Text(
          'Jumlah Total:',
          style: TextStyle(fontSize: 14, color: Colors.blueGrey),
        ),
        // Menghilangkan .0 pada hasil total
        Text(
          _total % 1 == 0 ? _total.toInt().toString() : _total.toStringAsFixed(2),
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: Colors.blue[700],
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