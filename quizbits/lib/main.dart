import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'theme/app_theme.dart';
import 'theme/theme_provider.dart'; 
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/main_navigation.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const QuizBits(),
    ),
  );
}

class QuizBits extends StatelessWidget {
  const QuizBits({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuizBits',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark, 
      themeMode: themeProvider.themeMode,
      home: const SplashScreen(),
      routes: {
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/main': (_) => const MainNavigation(),
      },
    );
  }
}