import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class FavoritSayaScreen extends StatelessWidget {
  const FavoritSayaScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Favorit Saya'), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context))),
      body: ListView(padding: const EdgeInsets.all(16), children: const [
        _Fav(image: 'https://images.unsplash.com/photo-1492571350019-22de08371fd3?w=400', title: 'Apa ibu kota Jepang?', cat: 'Geograph', views: '1.2K', rating: '4.8', time: '2 hari lalu'),
        _Fav(image: 'https://images.unsplash.com/photo-1611162616305-c69b3fa7fbe0?w=400', title: 'Tebak logo perusahaan ini?', cat: 'EASY', views: '620', rating: '4.4', time: '3 hari lalu'),
        _Fav(image: 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400', title: 'Makanan khas Jepang berikut ini adalah?', cat: 'Food', views: '640', rating: '4.3', time: '5 hari lalu'),
      ]),
    );
  }
}

class _Fav extends StatelessWidget {
  final String image, title, cat, views, rating, time;
  const _Fav({required this.image, required this.title, required this.cat, required this.views, required this.rating, required this.time});
  @override
  Widget build(BuildContext context){
    return Container(margin: const EdgeInsets.only(bottom: 12), decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE2E8F0)), borderRadius: BorderRadius.circular(12)), child: Row(children: [
      ClipRRect(borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)), child: Image.network(image, width: 90, height: 80, fit: BoxFit.cover)),
      Expanded(child: Padding(padding: const EdgeInsets.all(10), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12)),
        const SizedBox(height: 4),
        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(6)), child: Text(cat, style: GoogleFonts.poppins(fontSize: 9, color: AppColors.primary))),
        const SizedBox(height: 6),
        Row(children: [const Icon(Icons.visibility, size: 10, color: Color(0xFF64748B)), const SizedBox(width: 2), Text(views, style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF64748B))), const SizedBox(width: 8), const Icon(Icons.star, size: 10, color: AppColors.warning), const SizedBox(width: 2), Text(rating, style: GoogleFonts.poppins(fontSize: 10))]),
        const SizedBox(height: 2),
        Text(time, style: GoogleFonts.poppins(fontSize: 9, color: AppColors.textMuted)),
      ]))),
      const Padding(padding: EdgeInsets.only(right: 12), child: Icon(Icons.star, color: AppColors.warning, size: 20)),
    ]));
  }
}
