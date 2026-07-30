import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../../widgets/answer_option.dart';
import '../result/hasil_jawaban_screen.dart';
import '../comment/komentar_screen.dart';

// 1. Model Data untuk menyimpan struktur pertanyaan yang dibuat user
class QuestionModel {
  final String id;
  final String title;
  final String category;
  final String difficulty;
  final String authorName;
  final String createdAt;
  final String? imageUrl;
  final List<String> options;
  final int
      correctAnswerIndex; // Index jawaban benar (contoh: 0 = A, 1 = B, dst.)
  final int viewsCount;
  final double rating;
  final int ratingCount;
  final int commentsCount;

  QuestionModel({
    required this.id,
    required this.title,
    required this.category,
    required this.difficulty,
    required this.authorName,
    required this.createdAt,
    this.imageUrl,
    required this.options,
    required this.correctAnswerIndex,
    this.viewsCount = 0,
    this.rating = 0.0,
    this.ratingCount = 0,
    this.commentsCount = 0,
  });
}

class DetailPertanyaanScreen extends StatefulWidget {
  // 2. Menerima objek question secara dinamis dari halaman sebelumnya
  final QuestionModel question;

  const DetailPertanyaanScreen({
    super.key,
    required this.question,
  });

  @override
  State<DetailPertanyaanScreen> createState() => _DetailPertanyaanScreenState();
}

class _DetailPertanyaanScreenState extends State<DetailPertanyaanScreen> {
  int? selectedOptionIndex; // Menyimpan index pilihan user (0, 1, 2, dst.)
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    // Memudahkan akses data question
    final q = widget.question;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              // Logika share
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 1. GAMBAR SOAL (Ditampilkan hanya jika ada image URL)
          if (q.imageUrl != null && q.imageUrl!.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                q.imageUrl!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: AppColors.bgLight,
                    child: const Icon(
                      Icons.broken_image,
                      color: AppColors.textMuted,
                      size: 40,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
          ],

          // 2. BADGE KATEGORI & DIFFICULTY + FAVORITE
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  q.category,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  q.difficulty,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: AppColors.success,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => setState(() => isFavorited = !isFavorited),
                child: Icon(
                  isFavorited ? Icons.favorite : Icons.favorite_border,
                  size: 22,
                  color: isFavorited ? AppColors.danger : AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 3. JUDUL PERTANYAAN
          Text(
            q.title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),

          // 4. STATISTIK (VIEWS, RATING, AUTHOR)
          Row(
            children: [
              const Icon(
                Icons.visibility_outlined,
                size: 14,
                color: AppColors.textMuted,
              ),
              const SizedBox(width: 4),
              Text(
                '${q.viewsCount} views',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(width: 12),
              const Icon(
                Icons.star,
                size: 14,
                color: AppColors.warning,
              ),
              const SizedBox(width: 4),
              Text(
                '${q.rating} (${q.ratingCount} rating)',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'oleh ${q.authorName} • ${q.createdAt}',
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: AppColors.textMuted,
            ),
          ),

          const SizedBox(height: 12),

          // 5. BANNER KOMENTAR
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const KomentarScreen()),
            ),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: AppColors.bgLight,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.chat_bubble_outline,
                    size: 16,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${q.commentsCount} Komentar',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Lihat semua',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),
          Text(
            'Pilih jawaban yang benar',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),

          // 6. GENERATE PILIHAN JAWABAN DINAMIS
          ...List.generate(q.options.length, (index) {
            final optionLabel = String.fromCharCode(
                65 + index); // Konversi index ke A, B, C, D...
            final optionText = q.options[index];
            final isSelected = selectedOptionIndex == index;

            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: AnswerOption(
                label: optionLabel,
                text: optionText,
                selected: isSelected,
                onTap: () => setState(() => selectedOptionIndex = index),
              ),
            );
          }),

          const SizedBox(height: 16),

          // 7. TOMBOL SUBMIT
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: selectedOptionIndex == null
                  ? null
                  : () {
                      final isCorrect =
                          selectedOptionIndex == q.correctAnswerIndex;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HasilJawabanScreen(
                            isCorrect: isCorrect,
                          ),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Submit Jawaban',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
