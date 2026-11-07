import 'package:flutter/material.dart';
import 'package:library_mobile/app/config/routes.dart';
import 'package:library_mobile/data/models/sample_model.dart';
import 'package:library_mobile/features/shared/detail/views/detail_view.dart';

// Model data buku katalog
class CatalogBook {
  final int id;
  final String title;
  final String author;
  final String category; // 'Fiksi', 'Nonfiksi', 'Biografi'
  final String categoryDisplay; // misal: 'Fiksi · 2017'
  final int publishedYear;
  final int pageCount;
  final String? coverAsset;
  final String availableText;
  final int borrowCount;
  final double rating;
  final String description;

  const CatalogBook({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.categoryDisplay,
    required this.publishedYear,
    required this.pageCount,
    this.coverAsset,
    required this.availableText,
    required this.borrowCount,
    this.rating = 4.8,
    this.description = '',
  });

  SampleModel toSampleModel() => SampleModel(
        id: id,
        title: title,
        author: author,
        category: category,
        description: description,
        coverUrl: coverAsset,
        publishedYear: publishedYear,
        rating: rating,
        borrowCount: borrowCount,
      );
}

// Halaman Jelajahi & Pencarian Buku
class CatalogView extends StatefulWidget {
  final VoidCallback? onBackToHome;
  const CatalogView({super.key, this.onBackToHome});

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  // Palet warna dark mode
  static const Color _bg = Color(0xFF0B132B);
  static const Color _cardBg = Color(0xFF131D33);
  static const Color _cardBorder = Color(0xFF1E2D4A);
  static const Color _cyan = Color(0xFF00A8E8);
  static const Color _textGrey = Color(0xFF8E9BAE);
  static const Color _subGrey = Color(0xFF64748B);
  static const Color _availCyan = Color(0xFF38BDF8);

  static const List<String> _categories = [
    'Semua',
    'Fiksi',
    'Nonfiksi',
    'Biografi',
  ];

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'Semua';
  String _selectedSort = 'Populer';
  bool _showAll = false;

  // Buku pilihan pustakawan (Featured Card)
  static const CatalogBook _featuredBook = CatalogBook(
    id: 100,
    title: 'Laskar Pelangi',
    author: 'Andrea Hirata',
    category: 'Fiksi',
    categoryDisplay: 'FIKSI INDONESIA',
    publishedYear: 2005,
    pageCount: 529,
    coverAsset: 'assets/images/laskarPelangi.jpg',
    availableText: '• 7 buku tersedia',
    borrowCount: 350,
    rating: 4.9,
    description:
        'Kisah inspiratif tentang sepuluh anak di Belitung yang berjuang menuntut ilmu di tengah keterbatasan fasilitas sekolah.',
  );

  // Koleksi buku katalog
  static const List<CatalogBook> _allBooks = [
    CatalogBook(
      id: 1,
      title: 'Negara 5 Menara',
      author: 'Leila S. Chudori',
      category: 'Fiksi',
      categoryDisplay: 'Fiksi · 2017',
      publishedYear: 2017,
      pageCount: 420,
      coverAsset: 'assets/images/Book cover.png',
      availableText: '• 3 buku tersedia',
      borrowCount: 320,
      description:
          'Kisah persahabatan santri di Pondok Madani dengan kekuatan mantra Man Jadda Wajada.',
    ),
    CatalogBook(
      id: 2,
      title: 'Bumi Manusia',
      author: 'Tere Liye',
      category: 'Fiksi',
      categoryDisplay: 'Fantasi · 2014',
      publishedYear: 2014,
      pageCount: 535,
      coverAsset: 'assets/images/Book cover Bumi Manusia.png',
      availableText: '• 5 buku tersedia',
      borrowCount: 310,
      description:
          'Mahakarya roman tentang perjuangan Minke dan Annelies di masa kolonial Hindia Belanda.',
    ),
    CatalogBook(
      id: 3,
      title: 'Filosofi Teras',
      author: 'Henry Manampiring',
      category: 'Nonfiksi',
      categoryDisplay: 'Nonfiksi · 2018',
      publishedYear: 2018,
      pageCount: 320,
      coverAsset: 'assets/images/Book cover Filosofi Teras.png',
      availableText: '• 2 buku tersedia',
      borrowCount: 295,
      description:
          'Penerapan filsafat Stoisisme kuno untuk mental yang tangguh dan tenang.',
    ),
    CatalogBook(
      id: 4,
      title: 'Perahu Kertas',
      author: 'Dee Lestari',
      category: 'Fiksi',
      categoryDisplay: 'Fiksi · 2009',
      publishedYear: 2009,
      pageCount: 444,
      coverAsset: 'assets/images/Book cover Perahu Kertas.png',
      availableText: '• E-book tersedia',
      borrowCount: 280,
      description:
          'Kisah perahu kertas yang berlayar mencari pelabuhan hati antara Kugy dan Keenan.',
    ),
    CatalogBook(
      id: 5,
      title: 'Habibie & Ainun',
      author: 'B. J. Habibie',
      category: 'Biografi',
      categoryDisplay: 'Biografi · 2010',
      publishedYear: 2010,
      pageCount: 323,
      availableText: '• 4 buku tersedia',
      borrowCount: 260,
      description:
          'Kisah cinta abadi dan dedikasi penuh B.J. Habibie dan Hasri Ainun untuk bangsa.',
    ),
    CatalogBook(
      id: 6,
      title: 'Bung Karno',
      author: 'Cindy Adams',
      category: 'Biografi',
      categoryDisplay: 'Biografi · 2014',
      publishedYear: 2014,
      pageCount: 512,
      availableText: '• 2 buku tersedia',
      borrowCount: 245,
      description:
          'Penyambung Lidah Rakyat Indonesia: otobiografi proklamator yang dituturkan secara intim.',
    ),
    CatalogBook(
      id: 7,
      title: 'Atomic Habits',
      author: 'James Clear',
      category: 'Nonfiksi',
      categoryDisplay: 'Nonfiksi · 2018',
      publishedYear: 2018,
      pageCount: 315,
      coverAsset: 'assets/images/Book cover Atomic habtis.png',
      availableText: '• 6 buku tersedia',
      borrowCount: 275,
      description:
          'Perubahan kecil yang memberikan hasil luar biasa dalam membangun kebiasaan baik.',
    ),
    CatalogBook(
      id: 8,
      title: 'Steve Jobs',
      author: 'Walter Isaacson',
      category: 'Biografi',
      categoryDisplay: 'Biografi · 2011',
      publishedYear: 2011,
      pageCount: 656,
      availableText: '• 3 buku tersedia',
      borrowCount: 235,
      description:
          'Kisah inspiratif tentang kehidupan, kepemimpinan, dan inovasi sang visioner Apple.',
    ),
    CatalogBook(
      id: 9,
      title: 'The Psychology of Money',
      author: 'Morgan Housel',
      category: 'Nonfiksi',
      categoryDisplay: 'Nonfiksi · 2020',
      publishedYear: 2020,
      pageCount: 255,
      coverAsset: 'assets/images/Book cover Pyschology of money.png',
      availableText: '• 4 buku tersedia',
      borrowCount: 270,
      description:
          'Pelajaran abadi mengenai kekayaan, perilaku finansial, dan cara mengambil keputusan bijak.',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigateBackToHome() {
    if (widget.onBackToHome != null) {
      widget.onBackToHome!();
    } else if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.main);
    }
  }

  List<CatalogBook> get _filteredAndSortedBooks {
    final query = _searchQuery.trim().toLowerCase();
    final selected = _selectedCategory.toLowerCase().replaceAll(' ', '');

    final list = _allBooks.where((book) {
      final matchesCategory = _selectedCategory == 'Semua' ||
          book.category.toLowerCase().replaceAll(' ', '') == selected;
      final matchesSearch = query.isEmpty ||
          book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();

    if (_selectedSort == 'Populer') {
      list.sort((a, b) => b.borrowCount.compareTo(a.borrowCount));
    } else {
      list.sort((a, b) => b.publishedYear.compareTo(a.publishedYear));
    }
    return list;
  }

  void _openDetail(CatalogBook book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailView(book: book.toSampleModel())),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allFiltered = _filteredAndSortedBooks;
    final displayedBooks =
        (_showAll || _searchQuery.isNotEmpty || allFiltered.length <= 4)
            ? allFiltered
            : allFiltered.take(4).toList();

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          tooltip: 'Kembali ke Beranda',
          onPressed: _navigateBackToHome,
        ),
        titleSpacing: 0,
        title: const Text(
          'Pencarian',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 24),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Menu Pencarian Buku'),
                duration: Duration(seconds: 1),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              const Text(
                'Temukan bacaanmu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Cerita baru, sudut pandang baru.',
                style: TextStyle(color: _textGrey, fontSize: 13.5),
              ),
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 16),
              _buildCategoryChips(),
              const SizedBox(height: 24),
              _buildFeaturedSection(),
              const SizedBox(height: 26),
              _buildCollectionHeader(allFiltered.length),
              const SizedBox(height: 16),
              if (displayedBooks.isEmpty)
                _buildEmptyState()
              else ...[
                _buildGrid(displayedBooks),
                if (!_showAll && allFiltered.length > 4 && _searchQuery.isEmpty) ...[
                  const SizedBox(height: 20),
                  _buildShowMoreButton(),
                ],
              ],
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _cardBorder),
      ),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        cursorColor: _cyan,
        onChanged: (val) => setState(() => _searchQuery = val),
        decoration: InputDecoration(
          hintText: 'Cari judul atau penulis',
          hintStyle: const TextStyle(color: _subGrey, fontSize: 13.5),
          prefixIcon: const Icon(Icons.search, color: _subGrey, size: 22),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_searchQuery.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear, color: _textGrey, size: 18),
                  onPressed: () => setState(() {
                    _searchController.clear();
                    _searchQuery = '';
                  }),
                ),
              const Icon(Icons.tune_rounded, color: _cyan, size: 20),
              const SizedBox(width: 12),
            ],
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: _categories.map((category) {
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
              onTap: () => setState(() => _selectedCategory = category),
              borderRadius: BorderRadius.circular(8),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? _cyan : _cardBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: isSelected ? _cyan : _cardBorder),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : _textGrey,
                    fontSize: 13,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pilihan pustakawan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _cardBorder),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 95,
                  height: 138,
                  child: _buildCover(_featuredBook),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'FIKSI INDONESIA',
                      style: TextStyle(
                        color: _cyan,
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Laskar Pelangi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Andrea Hirata',
                      style: TextStyle(color: _textGrey, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '2005 · 529 halaman',
                      style: TextStyle(color: _subGrey, fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () => _openDetail(_featuredBook),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _cyan,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Lihat buku',
                              style: TextStyle(
                                color: Color(0xFF0B132B),
                                fontSize: 12.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: Color(0xFF0B132B),
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCollectionHeader(int totalCount) {
    final countText = (_selectedCategory == 'Semua' && _searchQuery.isEmpty)
        ? '128 buku untuk ditemukan'
        : '$totalCount buku untuk ditemukan';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Jelajahi koleksi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              countText,
              style: const TextStyle(color: _textGrey, fontSize: 12),
            ),
          ],
        ),
        PopupMenuButton<String>(
          initialValue: _selectedSort,
          onSelected: (val) => setState(() => _selectedSort = val),
          color: _cardBg,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: _cardBorder),
          ),
          offset: const Offset(0, 32),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _selectedSort,
                  style: const TextStyle(
                    color: _textGrey,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 2),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: _textGrey,
                  size: 18,
                ),
              ],
            ),
          ),
          itemBuilder: (_) => [
            _buildSortItem('Populer'),
            _buildSortItem('Terbaru'),
          ],
        ),
      ],
    );
  }

  PopupMenuItem<String> _buildSortItem(String label) {
    final isSelected = _selectedSort == label;
    return PopupMenuItem<String>(
      value: label,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? _cyan : Colors.white,
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isSelected)
            const Icon(Icons.check_rounded, color: _cyan, size: 16),
        ],
      ),
    );
  }

  Widget _buildGrid(List<CatalogBook> books) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: books.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 18,
        childAspectRatio: 0.57,
      ),
      itemBuilder: (_, index) => _buildBookCard(books[index]),
    );
  }

  Widget _buildBookCard(CatalogBook book) {
    return InkWell(
      onTap: () => _openDetail(book),
      borderRadius: BorderRadius.circular(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: double.infinity,
                child: _buildCover(book),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            book.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            book.author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: _textGrey, fontSize: 12),
          ),
          const SizedBox(height: 2),
          Text(
            book.categoryDisplay,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: _subGrey, fontSize: 11),
          ),
          const SizedBox(height: 3),
          Text(
            book.availableText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _availCyan,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCover(CatalogBook book) {
    if (book.coverAsset != null) {
      return Image.asset(
        book.coverAsset!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildPlaceholder(book),
      );
    }
    return _buildPlaceholder(book);
  }

  Widget _buildPlaceholder(CatalogBook book) {
    return Container(
      color: const Color(0xFF1E2D4A),
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.auto_stories_rounded, color: _cyan, size: 32),
            const SizedBox(height: 6),
            Text(
              book.category,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _textGrey,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShowMoreButton() {
    return InkWell(
      onTap: () => setState(() => _showAll = true),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _cardBorder),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tampilkan lebih banyak',
              style: TextStyle(
                color: _textGrey,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 6),
            Icon(Icons.keyboard_arrow_down_rounded, color: _textGrey, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          children: [
            const Icon(Icons.search_off_rounded, color: _textGrey, size: 54),
            const SizedBox(height: 14),
            const Text(
              'Buku tidak ditemukan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Coba cari dengan kata kunci lain atau pilih filter Semua.',
              textAlign: TextAlign.center,
              style: TextStyle(color: _textGrey, fontSize: 13),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _cyan,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => setState(() {
                _searchController.clear();
                _searchQuery = '';
                _selectedCategory = 'Semua';
              }),
              child: const Text(
                'Reset Filter',
                style: TextStyle(
                  color: Color(0xFF0B132B),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
