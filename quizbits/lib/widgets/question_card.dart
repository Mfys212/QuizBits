import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class QuestionCard extends StatelessWidget {
  final String image, title, views, answers, rating;
  final VoidCallback? onTap;
  const QuestionCard({super.key, required this.image, required this.title, required this.views, required this.answers, required this.rating, this.onTap});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface, // FIX: tadinya Colors.white
          borderRadius: BorderRadius.circular(16), 
          border: Border.all(color: theme.dividerColor.withValues(alpha: 0.2)), // FIX: tadinya AppColors.border
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)), 
            child: Image.network(image, height: 140, width: double.infinity, fit: BoxFit.cover)
          ),
          Padding(
            padding: const EdgeInsets.all(12), 
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                title, 
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, 
                  fontSize: 14,
                  // jangan kasih color, biar ngikut tema (hitam pas light, putih pas dark)
                )
              ),
              const SizedBox(height: 8),
              Row(children: [
                const Icon(Icons.visibility_outlined, size: 14, color: AppColors.textMuted), 
                const SizedBox(width: 4),
                Text(views, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted)),
                const SizedBox(width: 12),
                const Icon(Icons.chat_bubble_outline, size: 14, color: AppColors.textMuted), 
                const SizedBox(width: 4),
                Text(answers, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted)),
                const SizedBox(width: 12),
                const Icon(Icons.star, size: 14, color: AppColors.warning), 
                const SizedBox(width: 4),
                Text(rating, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted)),
              ])
            ])
          )
        ]),
      ),
    );
  }
}