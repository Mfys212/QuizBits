import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/theme_provider.dart';

class TemaScreen extends StatelessWidget {
  const TemaScreen({super.key});

  @override
  Widget build(BuildContext context){
    final themeProvider = context.watch<ThemeProvider>();
    final selected = themeProvider.selectedName;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor, // FIX
        scrolledUnderElevation: 0,
        title: const Text('Tema'), 
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context))
      ),
      body: ListView(
        padding: const EdgeInsets.all(20), 
        children: [
          Text('Pilih tampilan aplikasi yang sesuai dengan preferensimu.', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted)),
          const SizedBox(height: 20),
          
          _Option(icon: Icons.wb_sunny_outlined, title: 'Terang', selected: selected=='Terang', onTap: ()=> context.read<ThemeProvider>().setTheme('Terang')),
          const SizedBox(height: 12),
          _Option(icon: Icons.nightlight_outlined, title: 'Gelap', selected: selected=='Gelap', onTap: ()=> context.read<ThemeProvider>().setTheme('Gelap')),
          
          const SizedBox(height: 24),
          Text('Preview', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12), 
            decoration: BoxDecoration(
              color: theme.colorScheme.surface, // FIX
              border: Border.all(color: theme.dividerColor.withValues(alpha: 0.2)), 
              borderRadius: BorderRadius.circular(12)
            ), 
            child: Column(children: [
              Row(children: [const Icon(Icons.home, color: AppColors.primary), const SizedBox(width: 8), Text('Quizora', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12)), const Spacer(), Icon(Icons.call_outlined, size: 16, color: theme.iconTheme.color), const SizedBox(width: 8), Icon(Icons.more_vert, size: 16, color: theme.iconTheme.color)]),
              const SizedBox(height: 12),
              ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network('https://images.unsplash.com/photo-1492571350019-22de08371fd3?w=400', height: 80, width: double.infinity, fit: BoxFit.cover)),
            ])
          ),
        ]
      ),
    );
  }
}

class _Option extends StatelessWidget {
  final IconData icon; final String title; final String? subtitle; final bool selected; final VoidCallback onTap;
  // ignore: unused_element_parameter
  const _Option({required this.icon, required this.title, this.subtitle, required this.selected, required this.onTap});
  
  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap, 
      child: Container(
        padding: const EdgeInsets.all(14), 
        decoration: BoxDecoration(
          border: Border.all(color: selected?AppColors.primary:theme.dividerColor.withValues(alpha: 0.3), width: selected?1.5:1), 
          borderRadius: BorderRadius.circular(12), 
          color: selected? AppColors.primary.withValues(alpha: isDark? 0.2 : 0.1) : theme.colorScheme.surface // FIX tadinya primaryLight & Colors.white
        ), 
        child: Row(children: [
          Icon(icon, color: selected?AppColors.primary:AppColors.textMuted),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13))),
          Icon(selected?Icons.check_circle:Icons.circle_outlined, color: selected?AppColors.primary:AppColors.textMuted),
        ])
      )
    );
  }
}