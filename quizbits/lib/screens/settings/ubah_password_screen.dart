import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class UbahPasswordScreen extends StatelessWidget {
  const UbahPasswordScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Ubah Password'), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context))),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Center(child: Column(children: [
          Container(padding: const EdgeInsets.all(20), decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle), child: const Icon(Icons.lock, size: 50, color: AppColors.primary)),
          const SizedBox(height: 12),
          Text('Pastikan password baru berbeda dari sebelumnya.', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted), textAlign: TextAlign.center),
        ])),
        const SizedBox(height: 24),
        Text('Password Saat Ini', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        const TextField(obscureText: true, decoration: InputDecoration(hintText: 'Masukkan password saat ini', suffixIcon: Icon(Icons.visibility_off_outlined))),
        const SizedBox(height: 16),
        Text('Password Baru', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        const TextField(obscureText: true, decoration: InputDecoration(hintText: 'Masukkan password baru', suffixIcon: Icon(Icons.visibility_off_outlined))),
        const SizedBox(height: 16),
        Text('Konfirmasi Password Baru', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        const TextField(obscureText: true, decoration: InputDecoration(hintText: 'Masukkan ulang password baru', suffixIcon: Icon(Icons.visibility_off_outlined))),
        const SizedBox(height: 24),
        ElevatedButton(onPressed: (){}, child: const Text('Simpan Perubahan')),
      ]),
    );
  }
}
