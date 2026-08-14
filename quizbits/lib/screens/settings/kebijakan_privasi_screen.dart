import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class KebijakanPrivasiScreen extends StatelessWidget {
  const KebijakanPrivasiScreen({super.key});
  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // FIX
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor, // FIX
        scrolledUnderElevation: 0,
        title: const Text('Kebijakan Privasi'), 
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context))
      ),
      body: ListView(
        padding: const EdgeInsets.all(20), 
        children: [
          Text('Terakhir diperbarui: 20 Mei 2024', style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textMuted), textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Text('Kami sangat menghargai privasi kamu. Kebijakan ini menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi informasi pribadi kamu.', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted)),
          const SizedBox(height: 16),
          const _Section(num: '1.', title: 'Informasi yang Kami Kumpulkan', desc: 'Kami dapat mengumpulkan informasi seperti nama, email, dan data penggunaan aplikasi.'),
          const _Section(num: '2.', title: 'Penggunaan Informasi', desc: 'Informasi digunakan untuk menyediakan dan meningkatkan layanan kami.'),
          const _Section(num: '3.', title: 'Perlindungan Data', desc: 'Kami menerapkan langkah-langkah keamanan untuk melindungi data kamu.'),
          const _Section(num: '4.', title: 'Hak Pengguna', desc: 'Kamu memiliki hak untuk mengakses, memperbarui, atau menghapus data kamu.'),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: ()=>Navigator.pop(context), 
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
              ),
              child: Text('Saya Mengerti', style: GoogleFonts.poppins(fontWeight: FontWeight.w600))
            )
          ),
        ]
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String num, title, desc;
  const _Section({required this.num, required this.title, required this.desc});
  
  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, // FIX biar ada card gelap
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Text('$num $title', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 4),
          Text(desc, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted)), // FIX tadinya 0xFF64748B hardcode
        ]
      )
    );
  }
}