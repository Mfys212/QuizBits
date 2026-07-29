import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class TentangAplikasiScreen extends StatelessWidget {
  const TentangAplikasiScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Tentang Aplikasi'), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context))),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Center(child: Column(children: [
          Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(20)), child: const Icon(Icons.question_mark, color: Colors.white, size: 40)),
          const SizedBox(height: 12),
          Text('Quizora', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18)),
          Text('Versi 1.0.0', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted)),
          const SizedBox(height: 12),
          Text('Quizora adalah aplikasi game tanya jawab dan teka teki yang memungkinkan kamu belajar, bermain, dan berbagi pengetahuan bersama pengguna lain.', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted), textAlign: TextAlign.center),
        ])),
        const SizedBox(height: 24),
        ListTile(leading: const Icon(Icons.people_outline), title: Text('Tim Pengembang', style: GoogleFonts.poppins(fontSize: 13)), trailing: const Icon(Icons.chevron_right, size: 18), onTap: (){}),
        ListTile(leading: const Icon(Icons.language), title: Text('Kunjungi Website', style: GoogleFonts.poppins(fontSize: 13)), trailing: const Icon(Icons.chevron_right, size: 18), onTap: (){}),
        ListTile(leading: const Icon(Icons.mail_outline), title: Text('Hubungi Kami', style: GoogleFonts.poppins(fontSize: 13)), trailing: const Icon(Icons.chevron_right, size: 18), onTap: (){}),
      ]),
    );
  }
}
