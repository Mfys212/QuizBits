import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class KomentarScreen extends StatelessWidget {
  const KomentarScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Komentar (18)'), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context))),
      body: Column(children: [
        Expanded(child: ListView(padding: const EdgeInsets.all(16), children: const [
          _Item(name: 'Andi', time: '10 menit lalu', text: 'Mantap soalnya! Penjelasannya juga mudah dipahami 👍', likes: 12),
          _Item(name: 'Rina', time: '20 menit lalu', text: 'Lumayan sulit tapi seru 😅', likes: 8),
          _Item(name: 'Budi', time: '1 jam lalu', text: 'Bisa jadi referensi belajar nih!', likes: 5),
          _Item(name: 'Sari', time: '1 jam lalu', text: 'Aku kira Kyoto, ternyata Tokyo 😂', likes: 3),
        ])),
        Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: AppColors.border))), child: Row(children: [
          Expanded(child: TextField(decoration: InputDecoration(hintText: 'Tulis komentar...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)), contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)))),
          const SizedBox(width: 8),
          CircleAvatar(backgroundColor: AppColors.primary, child: IconButton(icon: const Icon(Icons.send, color: Colors.white, size: 18), onPressed: (){})),
        ]))
      ]),
    );
  }
}

class _Item extends StatelessWidget {
  final String name, time, text; final int likes;
  const _Item({required this.name, required this.time, required this.text, required this.likes});
  @override
  Widget build(BuildContext context){
    return Padding(padding: const EdgeInsets.only(bottom: 16), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CircleAvatar(radius: 18, backgroundColor: AppColors.primaryLight, child: Text(name[0])),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)), Text(time, style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textMuted))]),
        const SizedBox(height: 4),
        Text(text, style: GoogleFonts.poppins(fontSize: 12)),
        const SizedBox(height: 6),
        Row(children: [const Icon(Icons.favorite_border, size: 14, color: AppColors.danger), const SizedBox(width: 4), Text('$likes', style: GoogleFonts.poppins(fontSize: 11)), const SizedBox(width: 16), Text('Balas', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted))]),
      ]))
    ]));
  }
}
