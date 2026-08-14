import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class BahasaScreen extends StatefulWidget { const BahasaScreen({super.key}); @override State<BahasaScreen> createState() => _BahasaScreenState(); }

class _BahasaScreenState extends State<BahasaScreen> {
  String selected='ID';
  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // FIX
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor, // FIX
        scrolledUnderElevation: 0,
        title: const Text('Bahasa'), 
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context))
      ),
      body: ListView(
        padding: const EdgeInsets.all(20), 
        children: [
          Center(child: Column(children: [
            const Icon(Icons.language, size: 60, color: AppColors.primary),
            const SizedBox(height: 12),
            Text('Pilih bahasa yang ingin kamu gunakan.', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textMuted), textAlign: TextAlign.center),
          ])),
          const SizedBox(height: 24),
          _Lang(title: 'Bahasa Indonesia', subtitle: 'Default', selected: selected=='ID', onTap: ()=>setState(()=>selected='ID')),
          const SizedBox(height: 12),
          _Lang(title: 'English', subtitle: 'English', selected: selected=='EN', onTap: ()=>setState(()=>selected='EN')),
          const SizedBox(height: 12),
          _Lang(title: '日本語', subtitle: 'Jepang', selected: selected=='JP', onTap: ()=>setState(()=>selected='JP')),
        ]
      ),
    );
  }
}

class _Lang extends StatelessWidget {
  final String title, subtitle; final bool selected; final VoidCallback onTap;
  const _Lang({required this.title, required this.subtitle, required this.selected, required this.onTap});
  
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
          color: selected? AppColors.primary.withValues(alpha: isDark? 0.2 : 0.1) : theme.colorScheme.surface // FIX tadinya Colors.white & primaryLight
        ), 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)), 
              Text(subtitle, style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted))
            ]),
            Icon(selected?Icons.check_circle:Icons.circle_outlined, color: selected?AppColors.primary:AppColors.textMuted),
          ]
        )
      )
    );
  }
}