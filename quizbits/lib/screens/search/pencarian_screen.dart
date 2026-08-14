import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class PencarianScreen extends StatefulWidget { 
  const PencarianScreen({super.key}); 
  @override State<PencarianScreen> createState() => _PencarianScreenState(); 
}

class _PencarianScreenState extends State<PencarianScreen> with SingleTickerProviderStateMixin {
  final ctrl = TextEditingController(text: 'jepang');
  late TabController _tabController;
  bool _isPopping = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    ctrl.dispose();
    super.dispose();
  }

  Future<void> _handleBack() async {
    if (_isPopping) return;
    _isPopping = true;
    
    // 1. Tutup keyboard dulu
    FocusScope.of(context).unfocus();
    
    // 2. Tunggu animasi keyboard selesai (ini kunci dari log ImeTracker lu)
    await Future.delayed(const Duration(milliseconds: 200));
    
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context){
    return PopScope(
      canPop: false, // kita handle manual back nya
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _handleBack();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false, // cegah scaffold rebuild pas keyboard animasi
        appBar: AppBar(
          title: const Text('Pencarian'), 
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: _handleBack)
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(16), 
            child: TextField(
              controller: ctrl, 
              decoration: InputDecoration(
                hintText: 'Cari...', 
                prefixIcon: const Icon(Icons.search), 
                // JANGAN pakai TextButton di suffixIcon, ini bikin _dependents error
                // Ganti jadi IconButton
                suffixIcon: IconButton(
                  icon: Text('Batal', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.primary)),
                  onPressed: (){ 
                    ctrl.clear(); 
                    setState((){}); 
                  },
                ),
              )
            )
          ),
          TabBar(
            controller: _tabController,
            isScrollable: false, 
            labelColor: AppColors.primary, 
            tabs: const [Tab(text: 'Semua'), Tab(text: 'Pertanyaan'), Tab(text: 'Pengguna')]
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(padding: const EdgeInsets.all(16), children: const [
                  _Res(image: 'https://images.unsplash.com/photo-1492571350019-22de08371fd3?w=400', title: 'Apa ibu kota Jepang?', cat: 'Geography', views: '1.2K • 4.8'),
                  SizedBox(height: 12),
                  _Res(image: 'https://images.unsplash.com/photo-1492571350019-22de08371fd3?w=400', title: 'Siapa penemu origami di Jepang?', cat: 'History', views: '820 views • 4.5'),
                ]),
                Center(child: Text("List Pertanyaan")),
                Center(child: Text("List Pengguna")),
              ],
            )
          )
        ]),
      ),
    );
  }
}

class _Res extends StatelessWidget {
  final String image, title, cat, views;
  const _Res({required this.image, required this.title, required this.cat, required this.views});
  @override
  Widget build(BuildContext context){
    return Row(children: [
      ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(image, width: 70, height: 60, fit: BoxFit.cover)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12)),
        const SizedBox(height: 2),
        Text(cat, style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF64748B))),
      ]))
    ]);
  }
}