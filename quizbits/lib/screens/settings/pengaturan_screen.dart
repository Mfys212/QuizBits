import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import 'ubah_password_screen.dart';
import 'tema_screen.dart';
import 'bahasa_screen.dart';
import 'tentang_aplikasi_screen.dart';
import 'kebijakan_privasi_screen.dart';

class PengaturanScreen extends StatelessWidget {
  const PengaturanScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // FIX
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor, // FIX
        scrolledUnderElevation: 0,
        title: const Text('Pengaturan'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context))
      ),
      body: ListView(
        padding: const EdgeInsets.all(16), 
        children: [
          _Tile(icon: Icons.lock_outline, title: 'Ubah Password', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UbahPasswordScreen()))),
          _Tile(icon: Icons.notifications_outlined, title: 'Notifikasi', trailing: Switch(value: true, onChanged: (_) {}, activeThumbColor: AppColors.primary)),
          _Tile(icon: Icons.palette_outlined, title: 'Tema', subtitle: 'Light', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TemaScreen()))),
          _Tile(icon: Icons.language, title: 'Bahasa', subtitle: 'Indonesia', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BahasaScreen()))),
          Divider(color: theme.dividerColor.withValues(alpha: 0.2)), // FIX
          _Tile(icon: Icons.info_outline, title: 'Tentang Aplikasi', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TentangAplikasiScreen()))),
          _Tile(icon: Icons.privacy_tip_outlined, title: 'Kebijakan Privasi', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const KebijakanPrivasiScreen()))),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: AppColors.danger.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.logout, color: AppColors.danger),
              title: Text('Logout', style: GoogleFonts.poppins(color: AppColors.danger, fontSize: 13, fontWeight: FontWeight.w600)),
              onTap: () {},
            ),
          ),
        ]
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  const _Tile({required this.icon, required this.title, this.subtitle, this.trailing, this.onTap});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface, // FIX biar card
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.15)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, size: 20, color: theme.iconTheme.color),
        title: Text(title, style: GoogleFonts.poppins(fontSize: 13)),
        subtitle: subtitle != null? Text(subtitle!, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted)) : null,
        trailing: trailing?? const Icon(Icons.chevron_right, size: 18, color: AppColors.textMuted)
      ),
    );
  }
}