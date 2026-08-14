import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class BantuanFaqScreen extends StatelessWidget {
  const BantuanFaqScreen({super.key});
  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // FIX
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor, // FIX
        scrolledUnderElevation: 0,
        title: const Text('Bantuan & FAQ'), 
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context))
      ),
      body: ListView(
        padding: const EdgeInsets.all(16), 
        children: [
          Center(child: Column(children: [
            const Icon(Icons.help_outline, size: 50, color: AppColors.primary),
            const SizedBox(height: 8),
            Text('Temukan jawaban untuk pertanyaan yang sering diajukan.', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted), textAlign: TextAlign.center),
          ])),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'Cari pertanyaan...', 
              hintStyle: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5), // FIX
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              prefixIcon: const Icon(Icons.search, size: 18), 
            )
          ),
          const SizedBox(height: 20),
          Text('Pertanyaan Umum', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 12),
          const _Q('Cara bermain di Quizora?'),
          const _Q('Bagaimana cara mendapatkan reward?'),
          const _Q('Bagaimana cara membuat pertanyaan?'),
          const _Q('Saya lupa password, apa yang harus dilakukan?'),
          const _Q('Bagaimana cara menghubungi admin?'),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              onPressed: (){}, 
              icon: const Icon(Icons.mail_outline, size: 18), 
              label: Text('Hubungi Kami', style: GoogleFonts.poppins(fontWeight: FontWeight.w600))
            )
          ),
        ]
      ),
    );
  }
}

class _Q extends StatelessWidget {
  final String q;
  const _Q(this.q);
  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10), 
      decoration: BoxDecoration(
        color: theme.colorScheme.surface, // FIX
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.2)), // FIX tadinya 0xFFE2E8F0
        borderRadius: BorderRadius.circular(10)
      ), 
      child: ListTile(
        title: Text(q, style: GoogleFonts.poppins(fontSize: 12)), 
        trailing: const Icon(Icons.chevron_right, size: 16, color: AppColors.textMuted), 
        onTap: (){}
      )
    );
  }
}