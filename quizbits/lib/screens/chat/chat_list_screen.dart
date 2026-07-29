import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import 'detail_chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Chat')),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(16), child: TextField(decoration: InputDecoration(hintText: 'Search chat...', prefixIcon: const Icon(Icons.search), filled: true, fillColor: AppColors.bgLight, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)))),
        Expanded(child: ListView(children: [
          _Tile(name: 'Rina', msg: 'Halo, besok main quiz?', time: '10:20', unread: 2, onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const DetailChatScreen(name: 'Rina')))),
          const _Tile(name: 'Andi', msg: 'Iya, gas! 👍', time: '09:15', unread: 0),
          const _Tile(name: 'Budi', msg: 'Soal hari ini seru banget', time: 'Kemarin', unread: 0),
          const _Tile(name: 'Developer', msg: 'Pengumuman update aplikasi', time: '2 hari lalu', unread: 1),
          const _Tile(name: 'Sari', msg: 'Makasih yaa', time: '3 hari lalu', unread: 0),
        ]))
      ]),
    );
  }
}
class _Tile extends StatelessWidget {
  final String name, msg, time; final int unread; final VoidCallback? onTap;
  const _Tile({required this.name, required this.msg, required this.time, required this.unread, this.onTap});
  @override
  Widget build(BuildContext context){
    return ListTile(onTap: onTap, leading: CircleAvatar(backgroundColor: AppColors.primaryLight, child: Text(name[0])), title: Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)), subtitle: Text(msg, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted)), trailing: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text(time, style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textMuted)), if(unread>0) Container(margin: const EdgeInsets.only(top:4), padding: const EdgeInsets.symmetric(horizontal:6, vertical:2), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(10)), child: Text('$unread', style: const TextStyle(color: Colors.white, fontSize: 10)))]));
  }
}
