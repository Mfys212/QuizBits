import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

// 1. Model Data Komentar
class CommentItem {
  final String id;
  final String name;
  final String time;
  final String text;
  int likes;
  bool isLiked;

  CommentItem({
    required this.id,
    required this.name,
    required this.time,
    required this.text,
    required this.likes,
    this.isLiked = false,
  });
}

class KomentarScreen extends StatefulWidget {
  const KomentarScreen({super.key});

  @override
  State<KomentarScreen> createState() => _KomentarScreenState();
}

class _KomentarScreenState extends State<KomentarScreen> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // List Data Komentar (Dinamis)
  final List<CommentItem> _comments = [
    CommentItem(
      id: '1',
      name: 'Andi',
      time: '10 menit lalu',
      text: 'Mantap soalnya! Penjelasannya juga mudah dipahami 👍',
      likes: 12,
    ),
    CommentItem(
      id: '2',
      name: 'Rina',
      time: '20 menit lalu',
      text: 'Lumayan sulit tapi seru 😅',
      likes: 8,
    ),
    CommentItem(
      id: '3',
      name: 'Budi',
      time: '1 jam lalu',
      text: 'Bisa jadi referensi belajar nih!',
      likes: 5,
    ),
    CommentItem(
      id: '4',
      name: 'Sari',
      time: '1 jam lalu',
      text: 'Aku kira Kyoto, ternyata Tokyo 😂',
      likes: 3,
    ),
  ];

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Logika Tambah Komentar
  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _comments.insert(
        0, // Komentar baru muncul di paling atas
        CommentItem(
          id: DateTime.now().toString(),
          name: 'Saya', // Pengguna saat ini
          time: 'Baru saja',
          text: text,
          likes: 0,
        ),
      );
    });

    _commentController.clear();

    // Reset Scroll ke Paling Atas
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  // Logika Toggle Like
  void _toggleLike(int index) {
    setState(() {
      final comment = _comments[index];
      comment.isLiked = !comment.isLiked;
      if (comment.isLiked) {
        comment.likes++;
      } else {
        comment.likes--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text(
          'Komentar (${_comments.length})', // Counter Dinamis
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // LIST KOMENTAR DENGAN LAZY LOADING (OPTIMIZED)
            Expanded(
              child: _comments.isEmpty
                  ? Center(
                      child: Text(
                        'Belum ada komentar.\nJadilah yang pertama!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(color: AppColors.textMuted),
                      ),
                    )
                  : ListView.separated(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: _comments.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final item = _comments[index];
                        return _ItemTile(
                          item: item,
                          onLikePressed: () => _toggleLike(index),
                        );
                      },
                    ),
            ),

            // INPUT FORM KOMENTAR
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    offset: const Offset(0, -2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      minLines: 1,
                      maxLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: 'Tulis komentar...',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 13,
                          color: AppColors.textMuted,
                        ),
                        filled: true,
                        fillColor: AppColors.bgLight,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Material(
                    color: AppColors.primary,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: IconButton(
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: _addComment,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. Component Single Tile Komentar
class _ItemTile extends StatelessWidget {
  final CommentItem item;
  final VoidCallback onLikePressed;

  const _ItemTile({
    required this.item,
    required this.onLikePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // AVATAR USER
        CircleAvatar(
          radius: 18,
          backgroundColor: AppColors.primaryLight,
          child: Text(
            item.name[0],
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(width: 12),

        // ISI KOMENTAR & INFORMASI
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // NAMA & WAKTU
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.name,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    item.time,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // TEKS KOMENTAR
              Text(
                item.text,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 6),

              // TOMBOL INTERAKSI (LIKE & BALAS)
              Row(
                children: [
                  InkWell(
                    onTap: onLikePressed,
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 14,
                            color: item.isLiked
                                ? AppColors.danger
                                : AppColors.textMuted,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${item.likes}',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: item.isLiked
                                  ? AppColors.danger
                                  : AppColors.textMuted,
                              fontWeight: item.isLiked
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {}, // Logika untuk balas komentar
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      child: Text(
                        'Balas',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
