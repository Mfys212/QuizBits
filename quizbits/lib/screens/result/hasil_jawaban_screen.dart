import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../comment/komentar_screen.dart';

class HasilJawabanScreen extends StatefulWidget {
  final bool isCorrect;
  final String? questionTitle;
  final String? correctAnswer;
  final String? explanation;

  const HasilJawabanScreen({
    super.key,
    required this.isCorrect,
    this.questionTitle,
    this.correctAnswer,
    this.explanation,
  });

  @override
  State<HasilJawabanScreen> createState() => _HasilJawabanScreenState();
}

class _HasilJawabanScreenState extends State<HasilJawabanScreen> {
  int _selectedRating = 0;
  bool _hasRated = false;

  void _onRate(int star) {
    if (_hasRated) return; // Mencegah spam rating

    setState(() {
      _selectedRating = star;
      _hasRated = true;
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.stars, color: AppColors.warning, size: 20),
            const SizedBox(width: 8),
            Text(
              'Makasih rating $star bintangnya! +10 koin',
              style: GoogleFonts.poppins(fontSize: 12),
            ),
          ],
        ),
        backgroundColor: AppColors.textDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isCorrect = widget.isCorrect;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Hasil Jawaban',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),

                      // 1. HEADER IKON & STATUS
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              (isCorrect ? AppColors.success : AppColors.danger)
                                  .withValues(alpha: 0.1),
                        ),
                        child: Icon(
                          isCorrect
                              ? Icons.emoji_events_rounded
                              : Icons.cancel_rounded,
                          size: 56,
                          color:
                              isCorrect ? AppColors.success : AppColors.danger,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        isCorrect ? 'Jawaban Benar!' : 'Jawaban Salah!',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color:
                              isCorrect ? AppColors.success : AppColors.danger,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isCorrect
                            ? 'Luar biasa, kamu mendapatkan +20 Koin!'
                            : 'Jawaban yang benar: ${widget.correctAnswer ?? "Tokyo"}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: AppColors.textMuted,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // KARTU PENJELASAN
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.bgLight,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.lightbulb_outline_rounded,
                                  size: 18,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Penjelasan Soal',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: AppColors.textDark,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.explanation ??
                                  'Tokyo adalah ibu kota Jepang dan merupakan salah satu kawasan metropolitan terbesar di dunia dengan berbagai pusat kebudayaan dan teknologi.',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: AppColors.textMuted,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // SECTION RATING SOAL
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFF1F5F9),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Beri Rating Kualitas Soal',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(5, (index) {
                                final starValue = index + 1;
                                final isSelected = starValue <= _selectedRating;

                                return InkWell(
                                  onTap: () => _onRate(starValue),
                                  borderRadius: BorderRadius.circular(24),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Icon(
                                      isSelected
                                          ? Icons.star_rounded
                                          : Icons.star_border_rounded,
                                      color: isSelected
                                          ? AppColors.warning
                                          : const Color(0xFFCBD5E1),
                                      size: 34,
                                    ),
                                  ),
                                );
                              }),
                            ),
                            if (_hasRated) ...[
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    size: 14,
                                    color: AppColors.success,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Rating kamu telah tersimpan. Terima kasih!',
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: AppColors.success,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ACTION DISKUSI / KOMENTAR
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const KomentarScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                  Icons.chat_bubble_outline_rounded,
                                  size: 16),
                              label: const Text('Diskusi (18)'),
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                side:
                                    const BorderSide(color: AppColors.primary),
                                foregroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                textStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const KomentarScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.rate_review_outlined,
                                  size: 16),
                              label: const Text('Tulis Komentar'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                textStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // TOMBOL UTAMA (SOAL SELANJUTNYA)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Soal Selanjutnya',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
