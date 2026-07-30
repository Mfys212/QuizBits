import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class PencarianScreen extends StatefulWidget {
  const PencarianScreen({super.key});

  @override
  State<PencarianScreen> createState() => _PencarianScreenState();
}

class _PencarianScreenState extends State<PencarianScreen> {
  final TextEditingController _searchCtrl =
      TextEditingController(text: 'jepang');

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Pencarian',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [
            // INPUT PENCARIAN
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: TextField(
                controller: _searchCtrl,
                onChanged: (val) => setState(() {}),
                style: GoogleFonts.poppins(fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'Cari soal, topik, atau pengguna...',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.primary,
                    size: 22,
                  ),
                  suffixIcon: _searchCtrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.cancel_rounded,
                            color: Color(0xFF94A3B8),
                            size: 18,
                          ),
                          onPressed: () {
                            _searchCtrl.clear();
                            setState(() {});
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: AppColors.bgLight,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFF1F5F9)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
            ),

            // TAB CATEGORY FILTER
            TabBar(
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textMuted,
              indicatorColor: AppColors.primary,
              indicatorWeight: 2.5,
              labelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              unselectedLabelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
              tabs: const [
                Tab(text: 'Semua'),
                Tab(text: 'Pertanyaan'),
                Tab(text: 'Pengguna'),
              ],
            ),

            // 3. DAFTAR HASIL PENCARIAN
            Expanded(
              child: TabBarView(
                children: [
                  _buildSearchResultList(),
                  _buildSearchResultList(),
                  const Center(
                    child: Text('Pengguna tidak ditemukan'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Note: Widget ini nanti dari database (REST-API)
  Widget _buildSearchResultList() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      children: const [
        _SearchResultCard(
          image:
              'https://images.unsplash.com/photo-1492571350019-22de08371fd3?w=400',
          title: 'Apa ibu kota Jepang?',
          cat: 'Geography',
          views: '1.2K Dilihat',
          rating: '4.8',
        ),
        SizedBox(height: 12),
        _SearchResultCard(
          image:
              'https://images.unsplash.com/photo-1492571350019-22de08371fd3?w=400',
          title: 'Siapa penemu seni origami di Jepang?',
          cat: 'History',
          views: '820 Dilihat',
          rating: '4.5',
        ),
        SizedBox(height: 12),
        _SearchResultCard(
          image:
              'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400',
          title: 'Tebak makanan khas Jepang ini?',
          cat: 'Food',
          views: '640 Dilihat',
          rating: '4.3',
        ),
      ],
    );
  }
}

// COMPONENT KARTU HASIL PENCARIAN
class _SearchResultCard extends StatelessWidget {
  final String image;
  final String title;
  final String cat;
  final String views;
  final String rating;

  const _SearchResultCard({
    required this.image,
    required this.title,
    required this.cat,
    required this.views,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              image,
              width: 72,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 72,
                height: 64,
                color: AppColors.bgLight,
                child: const Icon(
                  Icons.image_not_supported_outlined,
                  color: AppColors.textMuted,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag Kategori
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    cat,
                    style: GoogleFonts.poppins(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                // Judul Soal
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                // Views & Rating Info
                Row(
                  children: [
                    Text(
                      views,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.star_rounded,
                      size: 13,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      rating,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
