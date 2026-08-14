import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../comment/komentar_screen.dart';

class HasilJawabanScreen extends StatefulWidget {
  final bool isCorrect;
  const HasilJawabanScreen({super.key, required this.isCorrect});
  @override
  State<HasilJawabanScreen> createState() => _HasilJawabanScreenState();
}

class _HasilJawabanScreenState extends State<HasilJawabanScreen> {
  int selectedRating = 4;
  bool hasRated = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // FIX
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor, // FIX
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Icon(Icons.emoji_events, size: 90, color: widget.isCorrect ? AppColors.warning : AppColors.textMuted),
            const SizedBox(height: 16),
            Text(widget.isCorrect ? 'Benar!' : 'Salah!',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w800, fontSize: 26, color: widget.isCorrect ? AppColors.success : AppColors.danger)),
            Text(widget.isCorrect ? 'Jawaban kamu benar' : 'Jawabannya Tokyo',
                style: GoogleFonts.poppins(color: AppColors.textMuted, fontSize: 13)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5), // FIX tadinya bgLight
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.dividerColor.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Penjelasan', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12)),
                  const SizedBox(height: 6),
                  Text('Tokyo adalah ibu kota Jepang dan merupakan kota terbesar di dunia dengan penduduk lebih dari 37 juta jiwa di wilayah metropolitan.',
                      style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted, height: 1.5)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Align(alignment: Alignment.centerLeft, child: Text('Beri Rating', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14))),
            const SizedBox(height: 8),
            Row(
              children: List.generate(5, (i) {
                int star = i + 1;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRating = star;
                      hasRated = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Kamu memberi $star bintang! +10 coin'), duration: const Duration(seconds: 1)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Icon(star <= selectedRating ? Icons.star : Icons.star_border, color: AppColors.warning, size: 32),
                  ),
                );
              }),
            ),
            if (hasRated)
              Padding(padding: const EdgeInsets.only(top: 6), child: Align(alignment: Alignment.centerLeft, child: Text('Makasih ratingnya! 🙏', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.success)))),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const KomentarScreen())),
                    icon: const Icon(Icons.chat_bubble_outline, size: 18),
                    label: const Text('Lihat Komentar (18)'),
                    style: OutlinedButton.styleFrom(foregroundColor: AppColors.primary, side: const BorderSide(color: AppColors.primary)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const KomentarScreen())),
                    icon: const Icon(Icons.rate_review_outlined, size: 18),
                    label: const Text('Tulis Komentar'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: Text('Pertanyaan Selanjutnya', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}