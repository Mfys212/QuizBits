import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../../widgets/answer_option.dart';
import '../result/hasil_jawaban_screen.dart';
import '../comment/komentar_screen.dart';

class DetailPertanyaanScreen extends StatefulWidget { 
  const DetailPertanyaanScreen({super.key}); 
  @override State<DetailPertanyaanScreen> createState() => _DetailPertanyaanScreenState(); 
}

class _DetailPertanyaanScreenState extends State<DetailPertanyaanScreen> {
  String? selected;
  bool isFavorited = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context)), 
        actions: [IconButton(icon: const Icon(Icons.share_outlined), onPressed: (){}), IconButton(icon: const Icon(Icons.more_vert), onPressed: (){})]
      ),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.network('https://images.unsplash.com/photo-1492571350019-22de08371fd3?w=800', height: 180, width: double.infinity, fit: BoxFit.cover)),
        const SizedBox(height: 12),
        Row(children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(8)), child: Text('Geography', style: GoogleFonts.poppins(fontSize: 10, color: AppColors.primary))),
          const SizedBox(width: 8), 
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(8)), child: Text('Easy', style: GoogleFonts.poppins(fontSize: 10, color: AppColors.success))),
          const Spacer(),
          // TOMBOL RATING PREVIEW + FAVORIT
          GestureDetector(
            onTap: ()=> setState(()=> isFavorited = !isFavorited),
            child: Icon(isFavorited ? Icons.favorite : Icons.favorite_border, size: 22, color: isFavorited ? AppColors.danger : AppColors.textMuted)
          ),
        ]),
        const SizedBox(height: 12),
        Text('Apa ibu kota Jepang?', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18)),
        const SizedBox(height: 8),
        Row(children: [
          const Icon(Icons.visibility_outlined, size: 14, color: AppColors.textMuted), const SizedBox(width: 4), 
          Text('1.200 views', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted)), 
          const SizedBox(width: 12), 
          const Icon(Icons.star, size: 14, color: AppColors.warning), const SizedBox(width: 4), 
          Text('4.8 (120 rating)', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted)),
        ]),
        const SizedBox(height: 6),
        Text('oleh Rizki • 2 hari yang lalu', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted)),
        
        const SizedBox(height: 12),
        InkWell(
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const KomentarScreen())),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(color: AppColors.bgLight, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
            child: Row(children: [
              const Icon(Icons.chat_bubble_outline, size: 16, color: AppColors.textMuted),
              const SizedBox(width: 8),
              Text('18 Komentar', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
              const Spacer(),
              Text('Lihat semua', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w600)),
              const Icon(Icons.chevron_right, size: 16, color: AppColors.primary),
            ]),
          ),
        ),

        const SizedBox(height: 12),
        Text('Pilih jawaban yang benar', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 12),
        AnswerOption(label: 'A', text: 'Tokyo', selected: selected=='A', onTap: ()=> setState(()=> selected='A')),
        AnswerOption(label: 'B', text: 'Osaka', selected: selected=='B', onTap: ()=> setState(()=> selected='B')),
        AnswerOption(label: 'C', text: 'Kyoto', selected: selected=='C', onTap: ()=> setState(()=> selected='C')),
        AnswerOption(label: 'D', text: 'Nagoya', selected: selected=='D', onTap: ()=> setState(()=> selected='D')),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: selected==null?null:()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> HasilJawabanScreen(isCorrect: selected=='A'))), child: const Text('Submit Jawaban')),
      ]),
    );
  }
}
