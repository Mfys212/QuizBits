import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class TemaScreen extends StatefulWidget { const TemaScreen({super.key}); @override State<TemaScreen> createState() => _TemaScreenState(); }

class _TemaScreenState extends State<TemaScreen> {
  String selected='Terang';
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Tema'), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context))),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Text('Pilih tampilan aplikasi yang sesuai dengan preferensimu.', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted)),
        const SizedBox(height: 20),
        _Option(icon: Icons.wb_sunny_outlined, title: 'Terang', selected: selected=='Terang', onTap: ()=> setState(()=>selected='Terang')),
        const SizedBox(height: 12),
        _Option(icon: Icons.nightlight_outlined, title: 'Gelap', selected: selected=='Gelap', onTap: ()=> setState(()=>selected='Gelap')),
        const SizedBox(height: 12),
        _Option(icon: Icons.phone_iphone, title: 'Otomatis', subtitle: 'Sesuaikan dengan pengaturan sistem', selected: selected=='Otomatis', onTap: ()=> setState(()=>selected='Otomatis')),
        const SizedBox(height: 24),
        Text('Preview', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 12),
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(12)), child: Column(children: [
          Row(children: [const Icon(Icons.home, color: AppColors.primary), const SizedBox(width: 8), Text('Quizora', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12)), const Spacer(), const Icon(Icons.call_outlined, size: 16), const SizedBox(width: 8), const Icon(Icons.more_vert, size: 16)]),
          const SizedBox(height: 12),
          ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network('https://images.unsplash.com/photo-1492571350019-22de08371fd3?w=400', height: 80, width: double.infinity, fit: BoxFit.cover)),
        ])),
      ]),
    );
  }
}

class _Option extends StatelessWidget {
  final IconData icon; final String title; final String? subtitle; final bool selected; final VoidCallback onTap;
  const _Option({required this.icon, required this.title, this.subtitle, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context){
    return GestureDetector(onTap: onTap, child: Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(border: Border.all(color: selected?AppColors.primary:AppColors.border, width: selected?1.5:1), borderRadius: BorderRadius.circular(12), color: selected?AppColors.primaryLight:Colors.white), child: Row(children: [
      Icon(icon, color: selected?AppColors.primary:AppColors.textMuted),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)), if(subtitle!=null) Text(subtitle!, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted))])),
      Icon(selected?Icons.check_circle:Icons.circle_outlined, color: selected?AppColors.primary:AppColors.textMuted),
    ])));
  }
}
