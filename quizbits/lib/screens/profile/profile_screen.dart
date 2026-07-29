import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import 'pertanyaan_saya_screen.dart';
import 'komentar_saya_screen.dart';
import 'favorit_saya_screen.dart';
import '../settings/pengaturan_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: [
        Container(padding: const EdgeInsets.fromLTRB(16, 50, 16, 20), decoration: const BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.vertical(bottom: Radius.circular(24))), child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const SizedBox(width: 24), Text('Profil', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)), const Icon(Icons.settings_outlined, color: Colors.white)]),
          const SizedBox(height: 20),
          Row(children: [
            CircleAvatar(radius: 30, backgroundColor: Colors.white, child: Text('R', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 22, color: AppColors.primary))),
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Rizki', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
              Text('rizki@email.com', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 6),
              Row(children: [const Icon(Icons.monetization_on, size: 14, color: AppColors.warning), const SizedBox(width: 4), Text('1,250', style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600))]),
            ]),
            const Spacer(),
            Text('Level 10', style: GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
          ]),
          const SizedBox(height: 12),
          ClipRRect(borderRadius: BorderRadius.circular(4), child: const LinearProgressIndicator(value: 0.7, backgroundColor: Colors.white24, valueColor: AlwaysStoppedAnimation<Color>(AppColors.warning))),
        ])),
        const SizedBox(height: 16),
        _Menu(icon: Icons.article_outlined, title: 'Pertanyaan Saya', count: '12', onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const PertanyaanSayaScreen()))),
        _Menu(icon: Icons.chat_bubble_outline, title: 'Komentar Saya', count: '34', onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const KomentarSayaScreen()))),
        _Menu(icon: Icons.favorite_border, title: 'Favorit Saya', count: '8', onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const FavoritSayaScreen()))),
        const Divider(height: 1),
        _Menu(icon: Icons.settings_outlined, title: 'Pengaturan', onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const PengaturanScreen()))),
        const _Menu(icon: Icons.help_outline, title: 'Bantuan & FAQ'),
        const _Menu(icon: Icons.logout, title: 'Logout', isLogout: true),
      ]),
    );
  }
}

class _Menu extends StatelessWidget {
  final IconData icon; final String title; final String? count; final bool isLogout; final VoidCallback? onTap;
  const _Menu({required this.icon, required this.title, this.count, this.isLogout=false, this.onTap});
  @override
  Widget build(BuildContext context){
    return ListTile(onTap: onTap, leading: Icon(icon, color: isLogout?AppColors.danger:AppColors.textDark, size: 20), title: Text(title, style: GoogleFonts.poppins(fontSize: 13, color: isLogout?AppColors.danger:AppColors.textDark)), trailing: Row(mainAxisSize: MainAxisSize.min, children: [if(count!=null) Text(count!, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted)), const SizedBox(width: 4), const Icon(Icons.chevron_right, size: 18, color: AppColors.textMuted)]));
  }
}
