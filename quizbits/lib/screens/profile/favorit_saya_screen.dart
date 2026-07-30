import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../detail/detail_pertanyaan_screen.dart';

class FavoritSayaScreen extends StatelessWidget {
  const FavoritSayaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Favorit Saya',
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
          // ITEM FAVORIT 1
          _Fav(
            question: QuestionModel(
              id: 'q_fav_1',
              title: 'Apa ibu kota Jepang?',
              category: 'Geograph',
              difficulty: 'Easy',
              authorName: 'Rizki',
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
          ),

          // ITEM FAVORIT 2
          _Fav(
            question: QuestionModel(
              id: 'q_fav_2',
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
          ),

          // ITEM FAVORIT 3
          _Fav(
            question: QuestionModel(
              id: 'q_fav_3',
              title: 'Makanan khas Jepang berikut ini adalah?',
              category: 'Food',
              difficulty: 'Easy',
              authorName: 'Siti',
              createdAt: '5 hari lalu',
              imageUrl:
                  'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=800',
              options: ['Sushi', 'Kimchi', 'Ramen', 'Dimsum'],
              correctAnswerIndex: 0,
              viewsCount: 640,
              rating: 4.3,
              ratingCount: 30,
              commentsCount: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _Fav extends StatelessWidget {
  final QuestionModel question;

  const _Fav({required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(12),
                ),
                child: Image.network(
                  question.imageUrl ?? 'https://via.placeholder.com/150',
                  width: 90,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          question.category,
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.visibility,
                            size: 10,
                            color: Color(0xFF64748B),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${question.viewsCount}',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.star,
                            size: 10,
                            color: AppColors.warning,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${question.rating}',
                            style: GoogleFonts.poppins(fontSize: 10),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        question.createdAt,
                        style: GoogleFonts.poppins(
                          fontSize: 9,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.star,
                  color: AppColors.warning,
                  size: 20,
                ),
                onPressed: () {
                  // Aksi untuk menghapus dari favorit
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
