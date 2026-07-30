import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'home/home_screen.dart';
import 'create/create_question_screen.dart';
import 'chat/chat_list_screen.dart';
import 'reward/reward_screen.dart';
import 'profile/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // Daftar Halaman (State!) - Oper ke Pool nanti biar di proses 1 arah
  final List<Widget> _pages = const [
    HomeScreen(),
    CreateQuestionScreen(),
    ChatListScreen(),
    RewardScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan IndexedStack agar state tiap tab tetap terjaga saat berpindah
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: AppColors.primary.withValues(alpha: 0.12),
              labelTextStyle: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  );
                }
                return GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMuted,
                );
              }),
            ),
            child: NavigationBar(
              height: 68,
              elevation: 0,
              backgroundColor: Colors.white,
              selectedIndex: _currentIndex,
              onDestinationSelected: (index) {
                setState(() => _currentIndex = index);
              },
              destinations: [
                // HOME
                const NavigationDestination(
                  icon: Icon(
                    Icons.home_outlined,
                    color: AppColors.textMuted,
                  ),
                  selectedIcon: Icon(
                    Icons.home_rounded,
                    color: AppColors.primary,
                  ),
                  label: 'Beranda',
                ),

                // 2. CREATE (Special Floating Look)
                NavigationDestination(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: AppColors.primary,
                      size: 22,
                    ),
                  ),
                  selectedIcon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  label: 'Buat',
                ),

                // CHAT (With Badge Example)
                const NavigationDestination(
                  icon: Badge(
                    label: Text('3'),
                    backgroundColor: AppColors.danger,
                    child: Icon(
                      Icons.chat_bubble_outline_rounded,
                      color: AppColors.textMuted,
                    ),
                  ),
                  selectedIcon: Badge(
                    label: Text('3'),
                    backgroundColor: AppColors.danger,
                    child: Icon(
                      Icons.chat_bubble_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                  label: 'Pesan',
                ),

                // REWARD
                const NavigationDestination(
                  icon: Icon(
                    Icons.emoji_events_outlined,
                    color: AppColors.textMuted,
                  ),
                  selectedIcon: Icon(
                    Icons.emoji_events_rounded,
                    color: AppColors.primary,
                  ),
                  label: 'Hadiah',
                ),

                // PROFILE
                const NavigationDestination(
                  icon: Icon(
                    Icons.person_outline_rounded,
                    color: AppColors.textMuted,
                  ),
                  selectedIcon: Icon(
                    Icons.person_rounded,
                    color: AppColors.primary,
                  ),
                  label: 'Profil',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
