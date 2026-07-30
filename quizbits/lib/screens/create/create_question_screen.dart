import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

// Model untuk mengelola controller dan status pilihan jawaban
class OptionModel {
  final TextEditingController controller;
  OptionModel() : controller = TextEditingController();
}

class CreateQuestionScreen extends StatefulWidget {
  const CreateQuestionScreen({super.key});

  @override
  State<CreateQuestionScreen> createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk field utama
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _explanationController = TextEditingController();

  // List dinamis untuk pilihan jawaban
  final List<OptionModel> _options = [
    OptionModel(),
    OptionModel(),
  ];

  // Index pilihan mana yang merupakan jawaban benar (Default: 0 = A)
  int _correctAnswerIndex = 0;

  @override
  void dispose() {
    _questionController.dispose();
    _explanationController.dispose();
    for (var option in _options) {
      option.controller.dispose();
    }
    super.dispose();
  }

  // Logika Tambah Opsi (Dipanggil oleh tombol 'Tambah Pilihan Jawaban')
  void _addOption() {
    if (_options.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maksimal 5 pilihan jawaban')),
      );
      return;
    }
    setState(() {
      _options.add(OptionModel());
    });
  }

  // Logika Hapus Opsi Spesifik
  void _removeOption(int index) {
    if (_options.length <= 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Minimal harus ada 2 pilihan jawaban')),
      );
      return;
    }

    setState(() {
      _options[index].controller.dispose();
      _options.removeAt(index);

      // Sesuaikan index jawaban benar jika opsi yang terhapus mempengaruhinya
      if (_correctAnswerIndex >= _options.length) {
        _correctAnswerIndex = _options.length - 1;
      }
    });
  }

  // Logika Submit / Publish
  void _submitQuestion() {
    if (!_formKey.currentState!.validate()) return;

    // Ambil data dari form
    final questionText = _questionController.text.trim();
    final explanationText = _explanationController.text.trim();
    final optionsList = _options.map((e) => e.controller.text.trim()).toList();
    final correctAnswer = optionsList[_correctAnswerIndex];

    // Response dummy untuk debug
    debugPrint('Pertanyaan: $questionText');
    debugPrint('Pilihan: $optionsList');
    debugPrint('Kunci Jawaban: $correctAnswer (Index: $_correctAnswerIndex)');
    debugPrint('Penjelasan: $explanationText');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pertanyaan berhasil dipublish!'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text(
          'Buat Pertanyaan',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // UPLOAD GAMBAR
              _buildSectionTitle('Upload Gambar (Opsional)'),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  // Logika image picker
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.bgLight,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.image_outlined,
                          color: AppColors.textMuted,
                          size: 28,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Pilih Gambar Soal',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // PERTANYAAN
              _buildSectionTitle('Pertanyaan'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _questionController,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Pertanyaan tidak boleh kosong';
                  }
                  return null;
                },
                decoration:
                    _inputDecoration('Tulis pertanyaan kamu di sini...'),
              ),
              const SizedBox(height: 20),

              // PILIHAN JAWABAN & KUNCI JAWABAN
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionTitle('Pilihan Jawaban'),
                  Text(
                    'Klik ikon/huruf untuk set kunci',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // LIST PILIHAN JAWABAN
              Column(
                children: List.generate(_options.length, (i) {
                  final optionLabel =
                      String.fromCharCode(65 + i); // A, B, C, dst.
                  final isCorrect = _correctAnswerIndex == i;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        // Radio Indicator
                        GestureDetector(
                          onTap: () => setState(() => _correctAnswerIndex = i),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              isCorrect
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                              color: isCorrect
                                  ? AppColors.primary
                                  : AppColors.textMuted,
                              size: 20,
                            ),
                          ),
                        ),

                        // Label Opsi A/B/C/D
                        GestureDetector(
                          onTap: () => setState(() => _correctAnswerIndex = i),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isCorrect
                                  ? AppColors.primary
                                  : AppColors.bgLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                optionLabel,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: isCorrect
                                      ? Colors.white
                                      : AppColors.textDark,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Input Text Opsi
                        Expanded(
                          child: TextFormField(
                            controller: _options[i].controller,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Opsi $optionLabel tidak boleh kosong';
                              }
                              return null;
                            },
                            decoration: _inputDecoration(
                              'Pilihan jawaban $optionLabel',
                            ),
                          ),
                        ),

                        // Tombol Hapus Opsi
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 18,
                            color: AppColors.danger,
                          ),
                          onPressed: () => _removeOption(i),
                        ),
                      ],
                    ),
                  );
                }),
              ),

              // TOMBOL TAMBAH PILIHAN (Sekarang Terhubung dengan _addOption)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: _addOption,
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(
                    'Tambah Pilihan Jawaban',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // PENJELASAN
              _buildSectionTitle('Penjelasan Jawaban (Opsional)'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _explanationController,
                maxLines: 2,
                decoration: _inputDecoration(
                  'Jelaskan alasan kenapa jawaban tersebut benar...',
                ),
              ),
              const SizedBox(height: 28),

              // TOMBOL PUBLISH
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _submitQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Publish Pertanyaan',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Section Title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
    );
  }

  // Helper Input Style
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(
        fontSize: 12,
        color: AppColors.textMuted,
      ),
      filled: true,
      fillColor: AppColors.bgLight,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      errorStyle: GoogleFonts.poppins(fontSize: 10),
    );
  }
}
