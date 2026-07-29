import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class CreateQuestionScreen extends StatefulWidget { const CreateQuestionScreen({super.key}); @override State<CreateQuestionScreen> createState() => _CreateQuestionScreenState(); }

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  int options=2;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Buat Pertanyaan'), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: (){})),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Text('Upload Gambar (Opsional)', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(height: 90, decoration: BoxDecoration(border: Border.all(color: AppColors.border, style: BorderStyle.solid), borderRadius: BorderRadius.circular(12), color: AppColors.bgLight), child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.image_outlined, color: AppColors.textMuted), const SizedBox(height: 4), Text('Pilih Gambar', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.primary))]))),
        const SizedBox(height: 16),
        Text('Pertanyaan', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        const TextField(maxLines: 3, decoration: InputDecoration(hintText: 'Tulis pertanyaan kamu di sini...')),
        const SizedBox(height: 16),
        Text('Jawaban Benar', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        const TextField(decoration: InputDecoration(hintText: 'Tulis jawaban yang benar...')),
        const SizedBox(height: 16),
        Text('Penjelasan (Opsional)', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        const TextField(decoration: InputDecoration(hintText: 'Jelaskan jawaban yang benar...')),
        const SizedBox(height: 16),
        Text('Pilihan Jawaban', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ...List.generate(options, (i)=> Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(children: [
          Container(width: 32, height: 32, decoration: BoxDecoration(color: AppColors.bgLight, borderRadius: BorderRadius.circular(8)), child: Center(child: Text(String.fromCharCode(65+i), style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12)))),
          const SizedBox(width: 8),
          const Expanded(child: TextField(decoration: InputDecoration(hintText: 'Pilihan jawaban \${i+1}'))),
          IconButton(icon: const Icon(Icons.close, size: 18), onPressed: (){ if(options>2) setState(()=>options--); })
        ]))),
        TextButton.icon(onPressed: ()=> setState(()=>options++), icon: const Icon(Icons.add), label: const Text('Tambah Pilihan')),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: (){ ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pertanyaan dipublish!'))); }, child: const Text('Publish Pertanyaan')),
        const SizedBox(height: 80),
      ]),
    );
  }
}
