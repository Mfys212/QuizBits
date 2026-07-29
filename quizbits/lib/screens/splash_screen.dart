import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../theme/app_colors.dart';

class SplashScreen extends StatefulWidget { 
  const SplashScreen({super.key}); 
  @override State<SplashScreen> createState() => _SplashScreenState(); 
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 2), (){
      if(mounted) Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( // <--- INI KUNCI BIAR GAK KEPOTONG NAV BAR
        child: Column(
          children: [
            const SizedBox(height: 80),
            Center(
              child: Column(children: [
                Container(
                  width: 84, height: 84,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Image.asset(
                        'assets/icon/icon.png',
                        width: 150,
                        height: 150,
                      )
                ),
                const SizedBox(height: 16),
                const Text('QUIZBITS', style: TextStyle(
                  fontWeight: FontWeight.w800, fontSize: 26, letterSpacing: 1.5)),
                const Text('Think. Guess. Win.', 
                  style: TextStyle(color: Color(0xFF64748B), fontSize: 13)),
              ]),
            ),
            const Spacer(),
            // ILUSTRASI - di tengah
            const Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.emoji_events, size: 110, color: Color(0xFFF59E0B)),
                Positioned(left: 60, top: 10, 
                  child: Icon(Icons.question_mark_rounded, size: 28, color: Color(0xFF6366F1))),
                Positioned(right: 50, top: 0, 
                  child: Icon(Icons.star, size: 14, color: Colors.orangeAccent)),
              ],
            ),
            const SizedBox(height: 20),
            Container(width: 28, height: 6, 
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1), 
                borderRadius: BorderRadius.circular(10))),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}