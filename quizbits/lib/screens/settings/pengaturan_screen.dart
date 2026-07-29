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
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Pengaturan'), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context))),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        _Tile(icon: Icons.lock_outline, title: 'Ubah Password', onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const UbahPasswordScreen()))),
        _Tile(icon: Icons.notifications_outlined, title: 'Notifikasi', trailing: Switch(value: true, onChanged: (_){}, activeColor: AppColors.primary)),
        _Tile(icon: Icons.palette_outlined, title: 'Tema', subtitle: 'Light', onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const TemaScreen()))),
        _Tile(icon: Icons.language, title: 'Bahasa', subtitle: 'Indonesia', onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const BahasaScreen()))),
        const Divider(),
        _Tile(icon: Icons.info_outline, title: 'Tentang Aplikasi', onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const TentangAplikasiScreen()))),
        _Tile(icon: Icons.privacy_tip_outlined, title: 'Kebijakan Privasi', onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const KebijakanPrivasiScreen()))),
        const SizedBox(height: 20),
        ListTile(leading: const Icon(Icons.logout, color: AppColors.danger), title: Text('Logout', style: GoogleFonts.poppins(color: AppColors.danger, fontSize: 13)), onTap: (){}),
      ]),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon; final String title; final String? subtitle; final Widget? trailing; final VoidCallback? onTap;
  const _Tile({required this.icon, required this.title, this.subtitle, this.trailing, this.onTap});
  @override
  Widget build(BuildContext context){
    return ListTile(onTap: onTap, leading: Icon(icon, size: 20), title: Text(title, style: GoogleFonts.poppins(fontSize: 13)), subtitle: subtitle!=null?Text(subtitle!, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted)):null, trailing: trailing ?? const Icon(Icons.chevron_right, size: 18, color: AppColors.textMuted));
  }
}
