import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscure = true; // <--- ini kuncinya

  @override
  Widget build(BuildContext context){
    return Scaffold(backgroundColor: Colors.white, body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 10),
      const Align(alignment: Alignment.topRight, child: Icon(Icons.more_horiz)),
      const SizedBox(height: 10),
      Text('Welcome Back!', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 22)),
      Text('Login to continue', style: GoogleFonts.poppins(color: AppColors.textMuted, fontSize: 13)),
      const SizedBox(height: 24),
      Center(child: Container(padding: const EdgeInsets.all(18), decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle), child: const Icon(Icons.lock, size: 56, color: AppColors.primary))),
      const SizedBox(height: 24),
      const TextField(decoration: InputDecoration(labelText: 'Email', hintText: 'youremail@gmail.com')),
      const SizedBox(height: 16),
      // PASSWORD FIELD FIX
      TextField(
        obscureText: _obscure,
        decoration: InputDecoration(
          labelText: 'Password', 
          hintText: '••••••',
          suffixIcon: IconButton(
            icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
            onPressed: () => setState(()=> _obscure = !_obscure),
          ),
        ),
      ),
      Align(alignment: Alignment.centerRight, child: TextButton(onPressed: (){}, child: Text('Forgot password?', style: GoogleFonts.poppins(fontSize: 12)))),
      const SizedBox(height: 8),
      ElevatedButton(onPressed: ()=> Navigator.pushReplacementNamed(context, '/main'), child: const Text('Login')),
      const SizedBox(height: 16),
      Row(children: [const Expanded(child: Divider()), Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text('Or continue with', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted))), const Expanded(child: Divider())]),
      const SizedBox(height: 16),
      Row(children: [
        Expanded(child: OutlinedButton.icon(onPressed: (){}, icon: const Icon(Icons.g_mobiledata, size: 28), label: const Text('Google'))),
        const SizedBox(width: 12),
        Expanded(child: OutlinedButton.icon(onPressed: (){}, icon: const Icon(Icons.apple), label: const Text('Apple'))),
      ]),
      const SizedBox(height: 20),
      Center(child: GestureDetector(onTap: ()=> Navigator.pushNamed(context, '/register'), child: Text.rich(TextSpan(children: [TextSpan(text: "Don't have an account? ", style: GoogleFonts.poppins(fontSize: 12)), TextSpan(text: 'Register', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600))])))),
    ]))));
  }
}
