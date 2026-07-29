import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class PertanyaanSayaScreen extends StatelessWidget {
  const PertanyaanSayaScreen({super.key});
  @override
  Widget build(BuildContext context){
    return DefaultTabController(length: 3, child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Pertanyaan Saya'), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context)), bottom: TabBar(labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12), tabs: [const Tab(text: 'Semua'), const Tab(text: 'Publik'), const Tab(text: 'Draft')])),
      body: TabBarView(children: [
        ListView(padding: const EdgeInsets.all(16), children: const [
          _QCard(title: 'Apa ibu kota Jepang?', status: 'Publik', views: '1.2K', answers: '18', rating: '4.8', image: 'https://images.unsplash.com/photo-1492571350019-22de08371fd3?w=400'),
          SizedBox(height: 12),
          _QCard(title: 'Berapa hasil dari 12 x 15?', status: 'Publik', views: '850', answers: '12', rating: '4.6', image: 'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=400'),
        ]),
        const Center(child: Text('Publik')),
        const Center(child: Text('Draft')),
      ]),
      floatingActionButton: FloatingActionButton(onPressed: (){}, backgroundColor: AppColors.primary, child: const Icon(Icons.add, color: Colors.white)),
    ));
  }
}

class _QCard extends StatelessWidget {
  final String title, status, views, answers, rating, image;
  const _QCard({required this.title, required this.status, required this.views, required this.answers, required this.rating, required this.image});
  @override
  Widget build(BuildContext context){
    return Container(decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE2E8F0)), borderRadius: BorderRadius.circular(12)), child: Row(children: [
      ClipRRect(borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)), child: Image.network(image, width: 80, height: 80, fit: BoxFit.cover)),
      Expanded(child: Padding(padding: const EdgeInsets.all(10), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12)),
        const SizedBox(height: 4),
        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: status=='Publik'?const Color(0xFFDCFCE7):const Color(0xFFFFF7ED), borderRadius: BorderRadius.circular(6)), child: Text(status, style: GoogleFonts.poppins(fontSize: 9, color: status=='Publik'?const Color(0xFF22C55E):const Color(0xFFF59E0B)))),
        const SizedBox(height: 6),
        Row(children: [const Icon(Icons.visibility, size: 10, color: Color(0xFF64748B)), const SizedBox(width: 2), Text(views, style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF64748B))), const SizedBox(width: 8), Text(rating, style: GoogleFonts.poppins(fontSize: 10))]),
      ]))),
      IconButton(icon: const Icon(Icons.more_vert, size: 18), onPressed: (){}),
    ]));
  }
}
