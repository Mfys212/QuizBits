import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class UbahPasswordScreen extends StatelessWidget {
  const UbahPasswordScreen({super.key});
  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // FIX
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor, // FIX
        scrolledUnderElevation: 0,
        title: const Text('Ubah Password'), 
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context))
      ),
      body: ListView(
        padding: const EdgeInsets.all(20), 
        children: [
          Center(child: Column(children: [
            Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.15), shape: BoxShape.circle), child: const Icon(Icons.lock, size: 50, color: AppColors.primary)), // FIX tadinya primaryLight
            const SizedBox(height: 12),
            Text('Pastikan password baru berbeda dari sebelumnya.', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted), textAlign: TextAlign.center),
          ])),
          const SizedBox(height: 24),
          Text('Password Saat Ini', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(
            obscureText: true, 
            decoration: InputDecoration(
              hintText: 'Masukkan password saat ini', 
              hintStyle: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5), // FIX
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              suffixIcon: const Icon(Icons.visibility_off_outlined)
            )
          ),
          const SizedBox(height: 16),
          Text('Password Baru', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(
            obscureText: true, 
            decoration: InputDecoration(
              hintText: 'Masukkan password baru', 
              hintStyle: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              suffixIcon: const Icon(Icons.visibility_off_outlined)
            )
          ),
          const SizedBox(height: 16),
          Text('Konfirmasi Password Baru', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(
            obscureText: true, 
            decoration: InputDecoration(
              hintText: 'Masukkan ulang password baru',
              hintStyle: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              suffixIcon: const Icon(Icons.visibility_off_outlined)
            )
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              onPressed: (){}, 
              child: Text('Simpan Perubahan', style: GoogleFonts.poppins(fontWeight: FontWeight.w600))
            )
          ),
        ]
      ),
    );
  }
}