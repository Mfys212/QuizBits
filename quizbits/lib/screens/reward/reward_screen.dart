import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // FIX
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor, // FIX
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('Reward Saya'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16), 
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Coin', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
                    const SizedBox(height: 4),
                    Row(children: [
                      const Icon(Icons.monetization_on, color: AppColors.warning),
                      const SizedBox(width: 6),
                      Text('1.250', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22))
                    ]),
                  ]
                ),
                Icon(Icons.card_giftcard, size: 48, color: Colors.white.withValues(alpha: 0.9)),
              ]
            )
          ),
          const SizedBox(height: 20),
          Text('Riwayat', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          const _Row(coin: '+100', title: 'Jawaban Benar', time: '2 jam lalu', color: AppColors.success),
          const _Row(coin: '+50', title: 'Komentar Disukai', time: '5 jam lalu', color: AppColors.success),
          const _Row(coin: '+200', title: 'Pertanyaan Populer', time: '1 hari lalu', color: AppColors.success),
          const _Row(coin: '-300', title: 'Tukar Hadiah', time: '2 hari lalu', color: AppColors.danger),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {}, 
              icon: const Icon(Icons.card_giftcard), 
              label: Text('Tukar Hadiah', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
              ),
            ),
          ),
        ]
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String coin, title, time;
  final Color color;
  const _Row({required this.coin, required this.title, required this.time, required this.color});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, // FIX biar ada card nya pas dark
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
          Row(children: [
            Text(coin, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: color, fontSize: 13)),
            const SizedBox(width: 12),
            Text(title, style: GoogleFonts.poppins(fontSize: 13))
          ]),
          Text(time, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted)),
        ]
      ),
    );
  }
}