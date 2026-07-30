import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscure1 = true;
  bool _obscure2 = true;
  bool _agree = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.white, actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close))
        ]),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Create Account',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700, fontSize: 22)),
              Text("Let's get you started",
                  style: GoogleFonts.poppins(
                      color: AppColors.textMuted, fontSize: 13)),
              const SizedBox(height: 24),
              const TextField(
                  decoration: InputDecoration(
                      labelText: 'Email', hintText: 'youremail@gmail.com')),
              const SizedBox(height: 16),

              // PASSWORD 1 - FIX SHOW/HIDE
              TextField(
                obscureText: _obscure1,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(_obscure1
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    onPressed: () => setState(() => _obscure1 = !_obscure1),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // CONFIRM PASSWORD - FIX SHOW/HIDE
              TextField(
                obscureText: _obscure2,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  suffixIcon: IconButton(
                    icon: Icon(_obscure2
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    onPressed: () => setState(() => _obscure2 = !_obscure2),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(children: [
                Checkbox(
                    value: _agree,
                    onChanged: (v) => setState(() => _agree = v ?? true),
                    activeColor: AppColors.primary),
                Expanded(
                    child: Text.rich(TextSpan(
                        text: 'I agree to the ',
                        style: GoogleFonts.poppins(fontSize: 11),
                        children: const [
                      TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(color: AppColors.primary))
                    ])))
              ]),
              const SizedBox(height: 12),
              ElevatedButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/main'),
                  child: const Text('Register')),
              const SizedBox(height: 20),
              Center(
                  child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Already have an account? ',
                            style: GoogleFonts.poppins(fontSize: 12)),
                        TextSpan(
                            text: 'Login',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600))
                      ])))),
            ])));
  }
}
