import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

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
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _explanationController = TextEditingController();
  final List<OptionModel> _options = [OptionModel(), OptionModel()];
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

  void _addOption() {
    if (_options.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maksimal 5 pilihan jawaban')),
      );
      return;
    }
    setState(() => _options.add(OptionModel()));
  }

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
      if (_correctAnswerIndex >= _options.length) {
        _correctAnswerIndex = _options.length - 1;
      }
    });
  }

  void _submitQuestion() {
    if (!_formKey.currentState!.validate()) return;
    final questionText = _questionController.text.trim();
    final explanationText = _explanationController.text.trim();
    final optionsList = _options.map((e) => e.controller.text.trim()).toList();
    final correctAnswer = optionsList[_correctAnswerIndex];
    debugPrint('Pertanyaan: $questionText');
    debugPrint('Pilihan: $optionsList');
    debugPrint('Kunci Jawaban: $correctAnswer (Index: $_correctAnswerIndex)');
    debugPrint('Penjelasan: $explanationText');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pertanyaan berhasil dipublish!'), backgroundColor: Colors.green),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // ignore: unused_local_variable
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // FIX
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor, // FIX tadinya Colors.white
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Buat Pertanyaan',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
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
              _buildSectionTitle(context, 'Upload Gambar (Opsional)'),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.dividerColor.withValues(alpha: 0.3)),
                    borderRadius: BorderRadius.circular(12),
                    color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5), // FIX
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.image_outlined, color: AppColors.textMuted, size: 28),
                        const SizedBox(height: 4),
                        Text(
                          'Pilih Gambar Soal',
                          style: GoogleFonts.poppins(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle(context, 'Pertanyaan'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _questionController,
                maxLines: 3,
                validator: (value) => (value == null || value.trim().isEmpty)? 'Pertanyaan tidak boleh kosong' : null,
                decoration: _inputDecoration(context, 'Tulis pertanyaan kamu di sini...'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionTitle(context, 'Pilihan Jawaban'),
                  Text('Klik ikon/huruf untuk set kunci', style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textMuted)),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                children: List.generate(_options.length, (i) {
                  final optionLabel = String.fromCharCode(65 + i);
                  final isCorrect = _correctAnswerIndex == i;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _correctAnswerIndex = i),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(isCorrect? Icons.radio_button_checked : Icons.radio_button_unchecked, color: isCorrect? AppColors.primary : AppColors.textMuted, size: 20),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => _correctAnswerIndex = i),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isCorrect? AppColors.primary : theme.colorScheme.surfaceContainerHighest, // FIX
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                optionLabel,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: isCorrect? Colors.white : theme.textTheme.bodyMedium?.color,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            controller: _options[i].controller,
                            validator: (value) => (value == null || value.trim().isEmpty)? 'Opsi $optionLabel tidak boleh kosong' : null,
                            decoration: _inputDecoration(context, 'Pilihan jawaban $optionLabel'),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 18, color: AppColors.danger),
                          onPressed: () => _removeOption(i),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: _addOption,
                  icon: const Icon(Icons.add, size: 18),
                  label: Text('Tambah Pilihan Jawaban', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle(context, 'Penjelasan Jawaban (Opsional)'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _explanationController,
                maxLines: 2,
                decoration: _inputDecoration(context, 'Jelaskan alasan kenapa jawaban tersebut benar...'),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _submitQuestion,
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
                  child: Text('Publish Pertanyaan', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        // FIX: jangan pakai AppColors.textDark, biar ngikut tema
        color: Theme.of(context).textTheme.bodyMedium?.color,
      ),
    );
  }

  InputDecoration _inputDecoration(BuildContext context, String hint) {
    final theme = Theme.of(context);
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted),
      filled: true,
      fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5), // FIX tadinya bgLight
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      errorStyle: GoogleFonts.poppins(fontSize: 10),
    );
  }
}