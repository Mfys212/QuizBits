import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class EditProfilScreen extends StatelessWidget {
  const EditProfilScreen({super.key});
  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // FIX
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor, // FIX
        scrolledUnderElevation: 0,
        title: const Text('Edit Profil'), 
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context))
      ),
      body: ListView(
        padding: const EdgeInsets.all(20), 
        children: [
          const Center(child: Stack(children: [
            CircleAvatar(radius: 45, backgroundColor: AppColors.primaryLight, child: Text('R', style: TextStyle(fontSize: 30, color: AppColors.primary, fontWeight: FontWeight.bold))), 
            Positioned(bottom: 0, right: 0, child: CircleAvatar(radius: 14, backgroundColor: Color(0xFF6366F1), child: Icon(Icons.camera_alt, size: 14, color: Colors.white)))
          ])),
          const SizedBox(height: 24),
          Text('Nama', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(
            decoration: InputDecoration(
              hintText: 'Rizki',
              hintStyle: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5), // FIX
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            )
          ),
          const SizedBox(height: 16),
          Text('Email', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(
            decoration: InputDecoration(
              hintText: 'rizki@email.com',
              hintStyle: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            )
          ),
          const SizedBox(height: 16),
          Text('Password Baru (Opsional)', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(
            obscureText: true, 
            decoration: InputDecoration(
              hintText: 'Masukkan password baru',
              hintStyle: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
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