import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class BantuanFaqScreen extends StatelessWidget {
  const BantuanFaqScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Bantuan & FAQ'), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context))),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Center(child: Column(children: [
          const Icon(Icons.help_outline, size: 50, color: AppColors.primary),
          const SizedBox(height: 8),
          Text('Temukan jawaban untuk pertanyaan yang sering diajukan.', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted), textAlign: TextAlign.center),
        ])),
        const SizedBox(height: 16),
        const TextField(decoration: InputDecoration(hintText: 'Cari pertanyaan...', prefixIcon: Icon(Icons.search), suffixIcon: Icon(Icons.search))),
        const SizedBox(height: 20),
        Text('Pertanyaan Umum', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 12),
        const _Q('Cara bermain di Quizora?'),
        const _Q('Bagaimana cara mendapatkan reward?'),
        const _Q('Bagaimana cara membuat pertanyaan?'),
        const _Q('Saya lupa password, apa yang harus dilakukan?'),
        const _Q('Bagaimana cara menghubungi admin?'),
        const SizedBox(height: 20),
        ElevatedButton.icon(onPressed: (){}, icon: const Icon(Icons.mail_outline, size: 18), label: const Text('Hubungi Kami')),
      ]),
    );
  }
}

class _Q extends StatelessWidget {
  final String q;
  const _Q(this.q);
  @override
  Widget build(BuildContext context){
    return Container(margin: const EdgeInsets.only(bottom: 10), decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE2E8F0)), borderRadius: BorderRadius.circular(10)), child: ListTile(title: Text(q, style: GoogleFonts.poppins(fontSize: 12)), trailing: const Icon(Icons.chevron_right, size: 16), onTap: (){}));
  }
}
