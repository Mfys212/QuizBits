import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart'; // tambahin ini

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    // PAKSA PAKAI THEME TERANG, GAK NGIKUT DARK MODE
    return Theme(
      data: AppTheme.light, // <-- ini kuncinya bro
      child: Scaffold(
        backgroundColor: Colors.white, // lock putih
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(alignment: Alignment.topRight, child: Icon(Icons.more_horiz, color: Colors.black)),
                  const SizedBox(height: 10),
                  Text('Welcome Back!', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 22, color: Colors.black)),
                  Text('Login to continue', style: GoogleFonts.poppins(color: AppColors.textMuted, fontSize: 13)),
                  const SizedBox(height: 24),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
                      child: const Icon(Icons.lock, size: 56, color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.black), // lock text hitam
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email', hintText: 'youremail@gmail.com'),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Email wajib diisi';
                      if (!value.contains('@')) return 'Format email tidak valid';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscure,
                    style: const TextStyle(color: Colors.black),
                    onFieldSubmitted: (_) => _handleLogin(),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: '••••••',
                      suffixIcon: IconButton(
                        icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Password wajib diisi';
                      if (value.length < 6) return 'Password minimal 6 karakter';
                      return null;
                    },
                  ),
                  Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () {}, child: Text('Forgot password?', style: GoogleFonts.poppins(fontSize: 12)))),
                  const SizedBox(height: 8),
                  SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _handleLogin, child: const Text('Login'))),
                  const SizedBox(height: 16),
                  Row(children: [
                    const Expanded(child: Divider()),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text('Or continue with', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted))),
                    const Expanded(child: Divider()),
                  ]),
                  const SizedBox(height: 16),
                  Row(children: [
                    Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.g_mobiledata, size: 28), label: const Text('Google'))),
                    const SizedBox(width: 12),
                    Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.apple), label: const Text('Apple'))),
                  ]),
                  const SizedBox(height: 20),
                  Center(
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, '/register'),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text.rich(TextSpan(children: [
                          TextSpan(text: "Don't have an account? ", style: GoogleFonts.poppins(fontSize: 12, color: Colors.black)),
                          TextSpan(text: 'Register', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
                        ])),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}