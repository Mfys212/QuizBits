import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../detail/detail_pertanyaan_screen.dart';

class KomentarSayaScreen extends StatelessWidget {
  const KomentarSayaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Komentar Saya',
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // KOMENTAR 1
          _Item(
            question: QuestionModel(
              id: 'q_com_1',
              title: 'Apa ibu kota Jepang?',
              category: 'Geography',
              difficulty: 'Easy',
              authorName: 'Admin',
              createdAt: '2 hari lalu',
              imageUrl:
                  'https://images.unsplash.com/photo-1492571350019-22de08371fd3?w=800',
              options: ['Tokyo', 'Osaka', 'Kyoto', 'Nagoya'],
              correctAnswerIndex: 0,
              viewsCount: 1200,
              rating: 4.8,
              ratingCount: 120,
              commentsCount: 18,
            ),
            time: '2 hari lalu',
            comment:
                'Tokyo adalah ibu kota Jepang dan merupakan kota terbesar di dunia!',
            likes: 12,
          ),

          // KOMENTAR 2
          _Item(
            question: QuestionModel(
              id: 'q_com_2',
              title: 'Tebak logo perusahaan ini?',
              category: 'Technology',
              difficulty: 'Medium',
              authorName: 'Budi',
              createdAt: '3 hari lalu',
              imageUrl:
                  'https://images.unsplash.com/photo-1611162616305-c69b3fa7fbe0?w=800',
              options: ['Instagram', 'TikTok', 'Spotify', 'Twitter'],
              correctAnswerIndex: 1,
              viewsCount: 620,
              rating: 4.4,
              ratingCount: 45,
              commentsCount: 25,
            ),
            time: '3 hari lalu',
            comment: 'Logo ini milik Netflix!',
            likes: 8,
          ),

          // KOMENTAR 3
          _Item(
            question: QuestionModel(
              id: 'q_com_3',
              title: 'Siapa penemu origami?',
              category: 'Art',
              difficulty: 'Hard',
              authorName: 'Siti',
              createdAt: '5 hari lalu',
              imageUrl:
                  'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=800',
              options: [
                'Akira Yoshizawa',
                'Hokusai',
                'Miyamoto Musashi',
                'Kenzo'
              ],
              correctAnswerIndex: 0,
              viewsCount: 410,
              rating: 4.7,
              ratingCount: 15,
              commentsCount: 6,
            ),
            time: '5 hari lalu',
            comment: 'Akira Yoshizawa dikenal sebagai bapak origami modern.',
            likes: 5,
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final QuestionModel question;
  final String time;
  final String comment;
  final int likes;

  const _Item({
    required this.question,
    required this.time,
    required this.comment,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailPertanyaanScreen(question: question),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // JUDUL SOAL & WAKTU
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        question.title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: AppColors.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // AVATAR & ISI KOMENTAR
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        'R',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        comment,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // AKSI LIKES & REPLIES
                Row(
                  children: [
                    const Icon(
                      Icons.thumb_up_outlined,
                      size: 14,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$likes',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.chat_bubble_outline,
                      size: 14,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Balas',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
