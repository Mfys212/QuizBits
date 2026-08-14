import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class TentangAplikasiScreen extends StatelessWidget {
  const TentangAplikasiScreen({super.key});
  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // FIX
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor, // FIX
        scrolledUnderElevation: 0,
        title: const Text('Tentang Aplikasi'), 
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context))
      ),
      body: ListView(
        padding: const EdgeInsets.all(20), 
        children: [
          Center(child: Column(children: [
            Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(20)), child: const Icon(Icons.question_mark, color: Colors.white, size: 40)),
            const SizedBox(height: 12),
            Text('Quizora', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18)),
            Text('Versi 1.0.0', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted)),
            const SizedBox(height: 12),
            Text('Quizora adalah aplikasi game tanya jawab dan teka teki yang memungkinkan kamu belajar, bermain, dan berbagi pengetahuan bersama pengguna lain.', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted), textAlign: TextAlign.center),
          ])),
          const SizedBox(height: 24),
          _InfoTile(icon: Icons.people_outline, title: 'Tim Pengembang', onTap: (){}),
          const SizedBox(height: 8),
          _InfoTile(icon: Icons.language, title: 'Kunjungi Website', onTap: (){}),
          const SizedBox(height: 8),
          _InfoTile(icon: Icons.mail_outline, title: 'Hubungi Kami', onTap: (){}),
        ]
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _InfoTile({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface, // FIX
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.15)),
      ),
      child: ListTile(
        leading: Icon(icon, size: 20, color: theme.iconTheme.color),
        title: Text(title, style: GoogleFonts.poppins(fontSize: 13)),
        trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.textMuted),
        onTap: onTap,
      ),
    );
  }
}