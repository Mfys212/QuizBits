import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../../widgets/question_card.dart';
import '../detail/detail_pertanyaan_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Profil Saya',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // Aksi ke pengaturan aplikasi
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // HEADER PROFIL
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 44,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      backgroundImage: const NetworkImage(
                        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=400',
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Rizki',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'rizki@example.com',
                  style: GoogleFonts.poppins(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // STATISTIK CARD
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.bgLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('24', 'Pertanyaan'),
                _buildDivider(),
                _buildStatItem('1,290', 'Koin'),
                _buildDivider(),
                _buildStatItem('85%', 'Akurasi'),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // DAFTAR MENU
          Text(
            'Aktivitas Saya',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),

          // QUESTION CARD DIBUAT USER
          QuestionCard(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPertanyaanScreen(
                    question: QuestionModel(
                      id: 'q_user_1',
                      title: 'Berapakah hasil dari 15 x 12?',
                      category: 'Math',
                      difficulty: 'Easy',
                      authorName: 'Rizki',
                      createdAt: '1 hari yang lalu',
                      imageUrl:
                          'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=800',
                      options: ['160', '180', '200', '150'],
                      correctAnswerIndex: 1, // 180
                      viewsCount: 340,
                      rating: 4.9,
                      ratingCount: 22,
                      commentsCount: 8,
                    ),
                  ),
                ),
              );
            },
            image:
                'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=800',
            title: 'Berapakah hasil dari 15 x 12?',
            views: '340',
            answers: '8',
            rating: '4.9',
          ),
          const SizedBox(height: 24),

          // OPSI PENGATURAN LAINNYA
          _buildMenuTile(
            icon: Icons.person_outline,
            title: 'Edit Profil',
            onTap: () {},
          ),
          _buildMenuTile(
            icon: Icons.history,
            title: 'Riwayat Jawaban',
            onTap: () {},
          ),
          _buildMenuTile(
            icon: Icons.help_outline,
            title: 'Bantuan & FAQ',
            onTap: () {},
          ),
          _buildMenuTile(
            icon: Icons.logout,
            title: 'Keluar',
            color: AppColors.danger,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // WIDGET HELPER
  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 24,
      width: 1,
      color: Colors.grey.shade300,
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    final tileColor = color ?? Colors.black87;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: tileColor, size: 22),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: tileColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}
