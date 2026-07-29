import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class AnswerOption extends StatelessWidget {
  final String label, text;
  final bool selected, isCorrectShow, isCorrect;
  final VoidCallback onTap;
  const AnswerOption({super.key, required this.label, required this.text, required this.selected, this.isCorrectShow=false, this.isCorrect=false, required this.onTap});
  @override
  Widget build(BuildContext context) {
    Color border = AppColors.border;
    Color bg = Colors.white;
    if(selected && !isCorrectShow){ border = AppColors.primary; bg = AppColors.primaryLight; }
    if(isCorrectShow && isCorrect){ border = AppColors.success; bg = const Color(0xFFDCFCE7); }
    if(isCorrectShow && selected && !isCorrect){ border = AppColors.danger; bg = const Color(0xFFFEE2E2); }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12), border: Border.all(color: border, width: selected?1.5:1)),
        child: Row(children: [
          Container(width: 28, height: 28, decoration: BoxDecoration(color: selected?AppColors.primary:Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: border)), child: Center(child: Text(label, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: selected?Colors.white:AppColors.textMuted)))),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: GoogleFonts.poppins(fontSize: 13))),
          if(isCorrectShow && isCorrect) const Icon(Icons.check_circle, color: AppColors.success, size: 20),
        ]),
      ),
    );
  }
}
