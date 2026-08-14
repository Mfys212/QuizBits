import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import 'detail_chat_screen.dart';

class ChatItem {
  final String name;
  final String msg;
  final String time;
  final int unread;
  final bool isOnline;
  const ChatItem({required this.name, required this.msg, required this.time, this.unread = 0, this.isOnline = false});
}

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});
  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final List<ChatItem> _allChats = const [
    ChatItem(name: 'Rina', msg: 'Halo, besok main quiz?', time: '10:20', unread: 2, isOnline: true),
    ChatItem(name: 'Andi', msg: 'Iya, gas! 👍', time: '09:15', unread: 0, isOnline: true),
    ChatItem(name: 'Budi', msg: 'Soal hari ini seru banget', time: 'Kemarin', unread: 0),
    ChatItem(name: 'Developer', msg: 'Pengumuman update aplikasi', time: '2 hari lalu', unread: 1),
    ChatItem(name: 'Sari', msg: 'Makasih yaa', time: '3 hari lalu', unread: 0),
  ];
  List<ChatItem> _filteredChats = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredChats = _allChats;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterChat(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredChats = _allChats;
      } else {
        _filteredChats = _allChats.where((chat) => chat.name.toLowerCase().contains(query.toLowerCase()) || chat.msg.toLowerCase().contains(query.toLowerCase())).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // FIX
      appBar: AppBar(
        title: Text('Chat', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor, // FIX
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: _filterChat,
              decoration: InputDecoration(
                hintText: 'Search chat...',
                hintStyle: GoogleFonts.poppins(fontSize: 13, color: AppColors.textMuted),
                prefixIcon: const Icon(Icons.search, size: 20),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5), // FIX
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: _filteredChats.isEmpty
              ? Center(child: Text('Tidak ada percakapan', style: GoogleFonts.poppins(color: AppColors.textMuted)))
                : ListView.separated(
                    itemCount: _filteredChats.length,
                    separatorBuilder: (context, index) => Divider(height: 1, indent: 72, color: theme.dividerColor.withValues(alpha: 0.2)), // FIX
                    itemBuilder: (context, index) {
                      final chat = _filteredChats[index];
                      return _Tile(chat: chat, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailChatScreen(name: chat.name))));
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final ChatItem chat;
  final VoidCallback? onTap;
  const _Tile({required this.chat, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUnread = chat.unread > 0;

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary.withValues(alpha: 0.15),
            child: Text(chat.name[0], style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: AppColors.primary)),
          ),
          if (chat.isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle, border: Border.all(color: theme.scaffoldBackgroundColor, width: 2)), // FIX biar border ngikut tema
              ),
            ),
        ],
      ),
      title: Text(chat.name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text(
        chat.msg,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: isUnread? theme.textTheme.bodyMedium?.color : AppColors.textMuted, // FIX tadinya Colors.black87
          fontWeight: isUnread? FontWeight.w500 : FontWeight.normal,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(chat.time, style: GoogleFonts.poppins(fontSize: 10, color: isUnread? AppColors.primary : AppColors.textMuted, fontWeight: isUnread? FontWeight.w600 : FontWeight.normal)),
          const SizedBox(height: 4),
          if (isUnread)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(10)),
              child: Text('${chat.unread}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            )
          else
            const SizedBox(height: 16),
        ],
      ),
    );
  }
}