import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class PencarianScreen extends StatefulWidget { const PencarianScreen({super.key}); @override State<PencarianScreen> createState() => _PencarianScreenState(); }

class _PencarianScreenState extends State<PencarianScreen> {
  final ctrl = TextEditingController(text: 'jepang');
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Pencarian'), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context))),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(16), child: TextField(controller: ctrl, decoration: InputDecoration(hintText: 'Cari...', prefixIcon: const Icon(Icons.search), suffixIcon: TextButton(onPressed: (){ ctrl.clear(); setState((){}); }, child: const Text('Batal'))))),
        const TabBar(isScrollable: false, labelColor: AppColors.primary, tabs: [Tab(text: 'Semua'), Tab(text: 'Pertanyaan'), Tab(text: 'Pengguna')]),
        Expanded(child: ListView(padding: const EdgeInsets.all(16), children: const [
          _Res(image: 'https://images.unsplash.com/photo-1492571350019-22de08371fd3?w=400', title: 'Apa ibu kota Jepang?', cat: 'Geography', views: '1.2K • 4.8'),
          SizedBox(height: 12),
          _Res(image: 'https://images.unsplash.com/photo-1492571350019-22de08371fd3?w=400', title: 'Siapa penemu origami di Jepang?', cat: 'History', views: '820 views • 4.5'),
          SizedBox(height: 12),
          _Res(image: 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400', title: 'Tebak makanan khas Jepang ini?', cat: 'Food', views: '640 views • 4.3'),
        ]))
      ]),
    );
  }
}

class _Res extends StatelessWidget {
  final String image, title, cat, views;
  const _Res({required this.image, required this.title, required this.cat, required this.views});
  @override
  Widget build(BuildContext context){
    return Row(children: [
      ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(image, width: 70, height: 60, fit: BoxFit.cover)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12)),
        const SizedBox(height: 2),
        Text(cat, style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF64748B))),
        const SizedBox(height: 2),
        Text(views, style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF64748B))),
      ]))
    ]);
  }
}
