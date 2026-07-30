import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class AnswerOption extends StatelessWidget {
  final String label;
  final String text;
  final bool selected;
  final bool isCorrectShow;
  final bool isCorrect;
  final VoidCallback onTap;

  const AnswerOption({
    super.key,
    required this.label,
    required this.text,
    required this.selected,
    this.isCorrectShow = false,
    this.isCorrect = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Penentuan Warna Latar Belakang & Border berdasarkan State
    Color borderColor = AppColors.border;
    Color backgroundColor = Colors.white;
    Color labelBgColor = const Color(0xFFF1F5F9);
    Color labelTextColor = AppColors.textMuted;
    Widget? trailingIcon;

    if (selected && !isCorrectShow) {
      borderColor = AppColors.primary;
      backgroundColor = AppColors.primaryLight;
      labelBgColor = AppColors.primary;
      labelTextColor = Colors.white;
    } else if (isCorrectShow) {
      if (isCorrect) {
        borderColor = AppColors.success;
        backgroundColor = const Color(0xFFDCFCE7);
        labelBgColor = AppColors.success;
        labelTextColor = Colors.white;
        trailingIcon = const Icon(
          Icons.check_circle_rounded,
          color: AppColors.success,
          size: 22,
        );
      } else if (selected && !isCorrect) {
        borderColor = AppColors.danger;
        backgroundColor = const Color(0xFFFEE2E2);
        labelBgColor = AppColors.danger;
        labelTextColor = Colors.white;
        trailingIcon = const Icon(
          Icons.cancel_rounded,
          color: AppColors.danger,
          size: 22,
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: borderColor,
            width: (selected || (isCorrectShow && isCorrect)) ? 2 : 1,
          ),
          boxShadow: [
            if (selected)
              BoxShadow(
                color: borderColor.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  // Label Option Container (A, B, C, D)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: labelBgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        label,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: labelTextColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Option Text
                  Expanded(
                    child: Text(
                      text,
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.w400,
                        color: AppColors.textDark,
                        height: 1.3,
                      ),
                    ),
                  ),

                  // Trailing Icon (Checkmark / Cross mark / Radio indicator)
                  if (trailingIcon != null) ...[
                    const SizedBox(width: 10),
                    trailingIcon,
                  ] else if (selected && !isCorrectShow) ...[
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.radio_button_checked_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
