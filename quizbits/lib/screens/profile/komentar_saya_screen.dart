import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class KomentarSayaScreen extends StatelessWidget {
  const KomentarSayaScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Komentar Saya'), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context))),
      body: ListView(padding: const EdgeInsets.all(16), children: const [
        _Item(q: 'Apa ibu kota Jepang?', time: '2 hari lalu', comment: 'Tokyo adalah ibu kota Jepang dan merupakan kota terbesar di dunia!', likes: 12),
        _Item(q: 'Tebak logo perusahaan ini?', time: '3 hari lalu', comment: 'Logo ini milik Netflix!', likes: 8),
        _Item(q: 'Siapa penemu origami?', time: '5 hari lalu', comment: 'Akira Yoshizawa dikenal sebagai bapak origami modern.', likes: 5),
      ]),
    );
  }
}

class _Item extends StatelessWidget {
  final String q, time, comment; final int likes;
  const _Item({required this.q, required this.time, required this.comment, required this.likes});
  @override
  Widget build(BuildContext context){
    return Container(margin: const EdgeInsets.only(bottom: 16), padding: const EdgeInsets.all(12), decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Expanded(child: Text(q, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12))), Text(time, style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textMuted))]),
      const SizedBox(height: 8),
      Row(children: [const CircleAvatar(radius: 14, child: Text('R', style: TextStyle(fontSize: 10))), const SizedBox(width: 8), Expanded(child: Text(comment, style: GoogleFonts.poppins(fontSize: 11)))]),
      const SizedBox(height: 8),
      Row(children: [const Icon(Icons.thumb_up_outlined, size: 14, color: AppColors.textMuted), const SizedBox(width: 4), Text('$likes', style: GoogleFonts.poppins(fontSize: 11)), const SizedBox(width: 16), const Icon(Icons.chat_bubble_outline, size: 14, color: AppColors.textMuted), const SizedBox(width: 4), Text('Balas', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted))]),
    ]));
  }
}
