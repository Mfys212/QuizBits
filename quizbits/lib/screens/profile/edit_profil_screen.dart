import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfilScreen extends StatelessWidget {
  const EditProfilScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Edit Profil'), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context))),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Center(child: Stack(children: [CircleAvatar(radius: 45, child: Text('R', style: TextStyle(fontSize: 30))), Positioned(bottom: 0, right: 0, child: CircleAvatar(radius: 14, backgroundColor: Color(0xFF6366F1), child: Icon(Icons.camera_alt, size: 14, color: Colors.white)))])),
        const SizedBox(height: 24),
        Text('Nama', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        const TextField(decoration: InputDecoration(hintText: 'Rizki')),
        const SizedBox(height: 16),
        Text('Email', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        const TextField(decoration: InputDecoration(hintText: 'rizki@email.com')),
        const SizedBox(height: 16),
        Text('Password Baru (Opsional)', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        const TextField(obscureText: true, decoration: InputDecoration(hintText: 'Masukkan password baru')),
        const SizedBox(height: 24),
        ElevatedButton(onPressed: (){}, child: const Text('Simpan Perubahan')),
      ]),
    );
  }
}
