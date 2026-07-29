import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class DetailChatScreen extends StatelessWidget {
  final String name;
  const DetailChatScreen({super.key, required this.name});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(title: Column(children: [Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)), Text('Online', style: GoogleFonts.poppins(fontSize: 10, color: AppColors.success))]), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context)), actions: [IconButton(icon: const Icon(Icons.call_outlined), onPressed: (){}), IconButton(icon: const Icon(Icons.more_vert), onPressed: (){})]),
      body: Column(children: [
        Expanded(child: ListView(padding: const EdgeInsets.all(16), children: const [
          _Bubble(text: 'Halo!', isMe: false, time: '10:20'),
          _Bubble(text: 'Hai Rina!', isMe: true, time: '10:21'),
          _Bubble(text: 'Besok main quiz bareng yuk?', isMe: false, time: '10:22'),
          _Bubble(text: 'Yuk bisa! Jam berapa?', isMe: true, time: '10:22'),
          _Bubble(text: 'Jam 8 malam gimana?', isMe: false, time: '10:23'),
          _Bubble(text: 'Oke deal! 😊', isMe: true, time: '10:24'),
        ])),
        Container(padding: const EdgeInsets.all(12), color: Colors.white, child: Row(children: [
          Expanded(child: TextField(decoration: InputDecoration(hintText: 'Ketik pesan...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)), contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)))),
          const SizedBox(width: 8),
          CircleAvatar(backgroundColor: AppColors.primary, child: IconButton(icon: const Icon(Icons.send, color: Colors.white, size: 18), onPressed: (){})),
        ]))
      ]),
    );
  }
}
class _Bubble extends StatelessWidget {
  final String text, time; final bool isMe;
  const _Bubble({required this.text, required this.time, required this.isMe});
  @override
  Widget build(BuildContext context){
    return Align(alignment: isMe?Alignment.centerRight:Alignment.centerLeft, child: Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10), constraints: const BoxConstraints(maxWidth: 240), decoration: BoxDecoration(color: isMe?AppColors.primary:Colors.white, borderRadius: BorderRadius.circular(16).copyWith(bottomRight: isMe?const Radius.circular(4):null, bottomLeft: !isMe?const Radius.circular(4):null)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(text, style: GoogleFonts.poppins(fontSize: 12, color: isMe?Colors.white:AppColors.textDark)), const SizedBox(height: 4), Text(time, style: GoogleFonts.poppins(fontSize: 9, color: isMe?Colors.white70:AppColors.textMuted))]))); 
  }
}
