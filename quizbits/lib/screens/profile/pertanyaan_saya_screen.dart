import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../detail/detail_pertanyaan_screen.dart';

class PertanyaanSayaScreen extends StatelessWidget {
  const PertanyaanSayaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock dataset untuk pertanyaan milik user
    final List<QuestionModel> myQuestions = [
      QuestionModel(
        id: 'q_my_1',
        title: 'Apa ibu kota Jepang?',
        category: 'Geography',
        difficulty: 'Easy',
        authorName: 'Saya',
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
      QuestionModel(
        id: 'q_my_2',
        title: 'Berapa hasil dari 12 x 15?',
        category: 'Mathematics',
        difficulty: 'Medium',
        authorName: 'Saya',
        createdAt: '1 minggu lalu',
        imageUrl:
            'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=800',
        options: ['160', '175', '180', '190'],
        correctAnswerIndex: 2,
        viewsCount: 850,
        rating: 4.6,
        ratingCount: 85,
        commentsCount: 12,
      ),
    ];

    final List<QuestionModel> draftQuestions = [
      QuestionModel(
        id: 'q_draft_1',
        title: 'Draf: Sebutkan nama-nama planet di tata surya?',
        category: 'Science',
        difficulty: 'Easy',
        authorName: 'Saya',
        createdAt: 'Baru saja',
        imageUrl:
            'https://images.unsplash.com/photo-1614728894747-a83421e2b9c9?w=800',
        options: ['Mercury', 'Venus', 'Earth', 'Mars'],
        correctAnswerIndex: 0,
        viewsCount: 0,
        rating: 0.0,
        ratingCount: 0,
        commentsCount: 0,
      ),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Pertanyaan Saya',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: TabBar(
            labelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textMuted,
            tabs: const [
              Tab(text: 'Semua'),
              Tab(text: 'Publik'),
              Tab(text: 'Draft'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // TAB 1: SEMUA
            _buildQuestionList(
              context,
              questions: [...myQuestions, ...draftQuestions],
              statuses: ['Publik', 'Publik', 'Draft'],
            ),

            // TAB 2: PUBLIK
            _buildQuestionList(
              context,
              questions: myQuestions,
              statuses: ['Publik', 'Publik'],
            ),

            // TAB 3: DRAFT
            _buildQuestionList(
              context,
              questions: draftQuestions,
              statuses: ['Draft'],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Action untuk tambah pertanyaan baru
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildQuestionList(
    BuildContext context, {
    required List<QuestionModel> questions,
    required List<String> statuses,
  }) {
    if (questions.isEmpty) {
      return Center(
        child: Text(
          'Belum ada pertanyaan',
          style: GoogleFonts.poppins(color: AppColors.textMuted),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: questions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _QCard(
          question: questions[index],
          status: statuses[index],
        );
      },
    );
  }
}

class _QCard extends StatelessWidget {
  final QuestionModel question;
  final String status;

  const _QCard({
    required this.question,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPublic = status == 'Publik';

    return Container(
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
              // THUMBNAIL GAMBAR
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(12),
                ),
                child: Image.network(
                  question.imageUrl ?? 'https://via.placeholder.com/150',
                  width: 85,
                  height: 85,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 85,
                    height: 85,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image_not_supported, size: 24),
                  ),
                ),
              ),

              // DETAIL SOAL
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      // BADGE STATUS
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isPublic
                              ? const Color(0xFFDCFCE7)
                              : const Color(0xFFFFF7ED),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          status,
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                            color: isPublic
                                ? const Color(0xFF22C55E)
                                : const Color(0xFFF59E0B),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),

                      // METRIKS (VIEWS, RATING, COMMENTS)
                      Row(
                        children: [
                          const Icon(
                            Icons.visibility_outlined,
                            size: 12,
                            color: Color(0xFF64748B),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${question.viewsCount}',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.star,
                            size: 12,
                            color: Color(0xFFEAB308),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${question.rating}',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.chat_bubble_outline,
                            size: 11,
                            color: Color(0xFF64748B),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${question.commentsCount}',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // OPSI MENU (EDIT/HAPUS)
              IconButton(
                icon: const Icon(Icons.more_vert, size: 18),
                onPressed: () {
                  // Tambahkan BottomSheet atau PopupMenu untuk opsi edit/hapus
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
