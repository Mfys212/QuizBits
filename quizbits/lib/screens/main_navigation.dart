import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'home/home_screen.dart';
import 'create/create_question_screen.dart';
import 'chat/chat_list_screen.dart';
import 'reward/reward_screen.dart';
import 'profile/profile_screen.dart';

class MainNavigation extends StatefulWidget { const MainNavigation({super.key}); @override State<MainNavigation> createState() => _MainNavigationState(); }

class _MainNavigationState extends State<MainNavigation> {
  int idx=0;
  final pages = const [HomeScreen(), CreateQuestionScreen(), ChatListScreen(), RewardScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: pages[idx],
      bottomNavigationBar: NavigationBar(
        height: 68,
        selectedIndex: idx,
        onDestinationSelected: (i)=>setState(()=>idx=i),
        // ignore: deprecated_member_use
        indicatorColor: AppColors.primary.withOpacity(0.15),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home, color: AppColors.primary), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.edit_outlined), selectedIcon: Icon(Icons.edit, color: AppColors.primary), label: 'Create'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble, color: AppColors.primary), label: 'Chat'),
          NavigationDestination(icon: Icon(Icons.emoji_events_outlined), selectedIcon: Icon(Icons.emoji_events, color: AppColors.primary), label: 'Reward'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person, color: AppColors.primary), label: 'Profile'),
        ],
      ),
    );
  }
}
