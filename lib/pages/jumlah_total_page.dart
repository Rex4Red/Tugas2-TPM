import 'package:flutter/material.dart';

class JumlahTotalPage extends StatefulWidget {
  const JumlahTotalPage({super.key});

  @override
  State<JumlahTotalPage> createState() => _JumlahTotalPageState();
}

class _JumlahTotalPageState extends State<JumlahTotalPage> {
  final _inputController = TextEditingController();

  List<String> _foundDigits = [];
  int _total = 0;
  bool _showResult = false;

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _hitung() {
    final text = _inputController.text;
    if (text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Input tidak boleh kosong')),
      );
      return;
    }

    final matches = RegExp(r'\d').allMatches(text);

    final extractedDigits = matches.map((m) => m.group(0)!).toList();

    setState(() {
      _foundDigits = extractedDigits;
      _total = extractedDigits.length;
      _showResult = true;
    });
  }

  void _reset() {
    _inputController.clear();
    setState(() {
      _foundDigits = [];
      _total = 0;
      _showResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Total Karakter Angka'),
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
                    Icons.find_in_page_rounded,
                    size: 48,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Pencari Karakter Angka',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Masukkan teks/paragraf, temukan semua angka di dalamnya',
                    textAlign: TextAlign.center,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Input Paragraf
                  TextFormField(
                    controller: _inputController,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: 'Masukkan Teks / Paragraf',
                      hintText:
                          'Contoh: Saya punya 3 kucing dan 2 anjing di rumah nomor 17',
                      alignLabelWithHint: true,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(bottom: 80),
                        child: Icon(Icons.text_fields_rounded),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      helperText:
                          'Semua karakter angka (0-9) akan diekstrak otomatis',
                    ),
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
                              'Cari Angka',
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
                            'Hasil Pencarian',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue[700],
                            ),
                          ),
                          const Divider(height: 24),

                          // Angka yang ditemukan
                          const Text(
                            'Angka yang ditemukan:',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                          const SizedBox(height: 8),

                          if (_foundDigits.isEmpty)
                            Text(
                              'Tidak ada angka ditemukan',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                                fontStyle: FontStyle.italic,
                              ),
                            )
                          else
                            // Tampilkan angka sebagai chips
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              alignment: WrapAlignment.center,
                              children: _foundDigits
                                  .asMap()
                                  .entries
                                  .map((entry) => Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.blue[50],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.blue[200]!),
                                        ),
                                        child: Text(
                                          entry.value,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.blue[700],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),

                          const SizedBox(height: 16),

                          // List format
                          if (_foundDigits.isNotEmpty) ...[
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'List: [${_foundDigits.map((d) => "'$d'").join(', ')}]',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'monospace',
                                  color: Colors.blueGrey[600],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],

                          // Total
                          const Text(
                            'Total Karakter Angka:',
                            style:
                                TextStyle(fontSize: 14, color: Colors.blueGrey),
                          ),
                          Text(
                            '$_total',
                            style: TextStyle(
                              fontSize: 48,
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
          ],
        ),
      ),
    );
  }
}