import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../../widgets/question_card.dart';
import '../detail/detail_pertanyaan_screen.dart';
import '../search/pencarian_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(children: [Text('Hi, Rizki', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16)), const Text(' 👋', style: TextStyle(fontSize: 16))]),
        actions: [Container(margin: const EdgeInsets.only(right: 16), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: const Color(0xFFFFF7ED), borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.warning.withOpacity(0.3))), child: Row(children: [const Icon(Icons.monetization_on, size: 16, color: AppColors.warning), const SizedBox(width: 4), Text('1,290', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12))]))],
      ),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        GestureDetector(onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const PencarianScreen())), child: TextField(enabled: false, decoration: InputDecoration(hintText: 'Search questions...', prefixIcon: const Icon(Icons.search), filled: true, fillColor: AppColors.bgLight, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)))),
        const SizedBox(height: 16),
        SizedBox(height: 72, child: ListView(scrollDirection: Axis.horizontal, children: const [
          _Chip(icon: Icons.apps, label: 'All', selected: true, color: AppColors.primary),
          _Chip(icon: Icons.science_outlined, label: 'Science', color: AppColors.secondaryCyan),
          _Chip(icon: Icons.calculate_outlined, label: 'Math', color: AppColors.warning),
          _Chip(icon: Icons.account_balance_outlined, label: 'History', color: AppColors.danger),
          _Chip(icon: Icons.category_outlined, label: 'Other', color: AppColors.textMuted),
        ])),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [const Icon(Icons.local_fire_department, color: AppColors.danger, size: 18), const SizedBox(width: 4), Text('Popular Questions', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14))]),
          Text('See all →', style: GoogleFonts.poppins(color: AppColors.primary, fontSize: 12))
        ]),
        const SizedBox(height: 12),
        QuestionCard(onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const DetailPertanyaanScreen())), image: 'https://images.unsplash.com/photo-1492571350019-22de08371fd3?w=800', title: 'Apa ibu kota Jepang?', views: '1.2K', answers: '18', rating: '4.8'),
        const SizedBox(height: 12),
        QuestionCard(onTap: (){}, image: 'https://images.unsplash.com/photo-1611162616305-c69b3fa7fbe0?w=800', title: 'Tebak logo perusahaan ini?', views: '620', answers: '25', rating: '4.4'),
      ]),
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon; final String label; final Color color; final bool selected;
  const _Chip({required this.icon, required this.label, required this.color, this.selected=false});
  @override
  Widget build(BuildContext context){
    return Container(margin: const EdgeInsets.only(right: 12), child: Column(children: [
      Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: selected?color:color.withOpacity(0.15), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: selected?Colors.white:color, size: 20)),
      const SizedBox(height: 4),
      Text(label, style: GoogleFonts.poppins(fontSize: 11, color: selected?color:AppColors.textMuted, fontWeight: selected?FontWeight.w600:FontWeight.normal))
    ]));
  }
}
