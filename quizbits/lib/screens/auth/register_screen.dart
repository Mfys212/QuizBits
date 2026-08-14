import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscure1 = true;
  bool _obscure2 = true;
  bool _agree = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap setujui Syarat & Ketentuan terlebih dahulu')),
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    // PAKSA TERANG KAYAK LOGIN
    return Theme(
      data: AppTheme.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: Colors.black),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create Account', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 22, color: Colors.black)),
                Text("Let's get you started", style: GoogleFonts.poppins(color: AppColors.textMuted, fontSize: 13)),
                const SizedBox(height: 24),

                TextFormField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.black),
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
                  obscureText: _obscure1,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(_obscure1 ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      onPressed: () => setState(() => _obscure1 = !_obscure1),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Password wajib diisi';
                    if (value.length < 6) return 'Password minimal 6 karakter';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscure2,
                  style: const TextStyle(color: Colors.black),
                  onFieldSubmitted: (_) => _handleRegister(),
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    suffixIcon: IconButton(
                      icon: Icon(_obscure2 ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      onPressed: () => setState(() => _obscure2 = !_obscure2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Konfirmasi password wajib diisi';
                    if (value != _passwordController.text) return 'Password tidak cocok';
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Checkbox(value: _agree, onChanged: (v) => setState(() => _agree = v ?? false), activeColor: AppColors.primary),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: 'I agree to the ',
                          style: GoogleFonts.poppins(fontSize: 11, color: Colors.black),
                          children: const [
                            TextSpan(text: 'Terms & Conditions', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: _agree ? _handleRegister : null, child: const Text('Register')),
                ),
                const SizedBox(height: 20),

                Center(
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text.rich(TextSpan(children: [
                        TextSpan(text: 'Already have an account? ', style: GoogleFonts.poppins(fontSize: 12, color: Colors.black)),
                        TextSpan(text: 'Login', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
                      ])),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}