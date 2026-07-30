import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../settings/pengaturan_screen.dart';
import 'favorit_saya_screen.dart';
import 'komentar_saya_screen.dart';
import 'pertanyaan_saya_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // 1. HEADER PROFILE (CARD BLUE)
          Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                // TITLE BAR & SETTINGS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 24),
                    Text(
                      'Profil Saya',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings_outlined,
                          color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PengaturanScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // USER INFO
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: Text(
                        'R',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rizki',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'rizki@email.com',
                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.monetization_on,
                                size: 14,
                                color: AppColors.warning,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '1,250 Koin',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Lvl 10',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // PROGRESS EXP / LEVEL
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progres Level',
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          '70%',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: const LinearProgressIndicator(
                        value: 0.7,
                        minHeight: 6,
                        backgroundColor: Colors.white24,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.warning,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 2. AKTIVITAS MENU
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Aktivitas',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
              ),
            ),
          ),

          _MenuTile(
            icon: Icons.article_outlined,
            title: 'Pertanyaan Saya',
            count: '12',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PertanyaanSayaScreen()),
            ),
          ),
          _MenuTile(
            icon: Icons.chat_bubble_outline,
            title: 'Komentar Saya',
            count: '34',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const KomentarSayaScreen()),
            ),
          ),
          _MenuTile(
            icon: Icons.favorite_border,
            title: 'Favorit Saya',
            count: '8',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FavoritSayaScreen()),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Divider(height: 1),
          ),

          // 3. PENGATURAN & BANTUAN
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Lainnya',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
              ),
            ),
          ),

          _MenuTile(
            icon: Icons.settings_outlined,
            title: 'Pengaturan',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PengaturanScreen()),
            ),
          ),
          _MenuTile(
            icon: Icons.help_outline,
            title: 'Bantuan & FAQ',
            onTap: () {
              // Aksi Bantuan
            },
          ),
          _MenuTile(
            icon: Icons.logout,
            title: 'Logout',
            isLogout: true,
            onTap: () {
              // Action logout modal dialog
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? count;
  final bool isLogout;
  final VoidCallback? onTap;

  const _MenuTile({
    required this.icon,
    required this.title,
    this.count,
    this.isLogout = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isLogout ? AppColors.danger : AppColors.textDark;

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: Icon(icon, color: color, size: 20),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 13,
          color: color,
          fontWeight: isLogout ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (count != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.bgLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                count!,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: 6),
          ],
          Icon(
            Icons.chevron_right,
            size: 18,
            color: isLogout ? AppColors.danger : AppColors.textMuted,
          ),
        ],
      ),
    );
  }
}
