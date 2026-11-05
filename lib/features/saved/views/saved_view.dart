import 'package:flutter/material.dart';
import 'package:library_mobile/data/models/sample_model.dart';
import 'package:library_mobile/features/detail/views/detail_view.dart';

// Model data buku tersimpan
class SavedBook {
  final int id;
  final String title;
  final String author;
  final String category;
  final int publishedYear;
  final int pageCount;
  final String? coverAsset;
  final String description;

  const SavedBook({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.publishedYear,
    required this.pageCount,
    this.coverAsset,
    this.description = '',
  });

  // Konversi ke SampleModel untuk diteruskan ke halaman Detail
  SampleModel toSampleModel() {
    return SampleModel(
      id: id,
      title: title,
      author: author,
      category: category,
      description: description,
      coverUrl: coverAsset,
      publishedYear: publishedYear,
    );
  }
}

// Halaman Tersimpan (SavedView)
class SavedView extends StatefulWidget {
  const SavedView({super.key});

  @override
  State<SavedView> createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView> {
  // Skema warna dark mode dengan aksen cyan (konsisten dengan tema aplikasi)
  static const Color _bg = Color(0xFF0B132B);
  static const Color _cardBg = Color(0xFF131D33);
  static const Color _cardBorder = Color(0xFF1E2D4A);
  static const Color _cyan = Color(0xFF00A8E8);
  static const Color _textGrey = Color(0xFF8E9BAE);
  static const Color _subGrey = Color(0xFF64748B);

  // Controller untuk fitur pencarian judul buku
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = '';

  // Data dummy 4 buku sesuai spesifikasi
  final List<SavedBook> _initialBooks = const [
    SavedBook(
      id: 1,
      title: 'Laskar Pelangi',
      author: 'Andrea Hirata',
      category: 'FIKSI INDONESIA',
      publishedYear: 2005,
      pageCount: 529,
      coverAsset: 'assets/images/laskarPelangi.jpg',
      description: 'Kisah inspiratif tentang sepuluh anak di Belitung yang berjuang menuntut ilmu di tengah keterbatasan fasilitas sekolah.',
    ),
    SavedBook(
      id: 2,
      title: 'Negeri 5 Menara',
      author: 'Leila S. Chudori',
      category: 'FIKSI INDONESIA',
      publishedYear: 2017,
      pageCount: 555,
      coverAsset: null,
      description: 'Kisah persahabatan enam santri dari berbagai daerah di Indonesia yang menuntut ilmu di Pondok Madani.',
    ),
    SavedBook(
      id: 3,
      title: 'Atomic Habits',
      author: 'James Clear',
      category: 'SELF-HELP BOOK',
      publishedYear: 2018,
      pageCount: 315,
      coverAsset: null,
      description: 'Perubahan kecil yang memberikan hasil luar biasa dalam membangun kebiasaan baik dan mematahkan kebiasaan buruk.',
    ),
    SavedBook(
      id: 4,
      title: 'The Psychology of Money',
      author: 'Morgan Housel',
      category: 'SELF-HELP BOOK',
      publishedYear: 2020,
      pageCount: 255,
      coverAsset: null,
      description: 'Pelajaran abadi mengenai kekayaan, ketamakan, dan kebahagiaan dalam mengambil keputusan finansial.',
    ),
  ];

  late List<SavedBook> _books;

  @override
  void initState() {
    super.initState();
    _books = List<SavedBook>.from(_initialBooks);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter daftar buku berdasarkan query pencarian judul
  List<SavedBook> get _filteredBooks {
    if (_searchQuery.trim().isEmpty) {
      return _books;
    }
    return _books.where((book) {
      return book.title.toLowerCase().contains(
        _searchQuery.toLowerCase().trim(),
      );
    }).toList();
  }

  // Fungsi menghapus buku dari daftar tersimpan
  void _removeBook(SavedBook book) {
    final index = _books.indexOf(book);
    if (index == -1) return;

    setState(() {
      _books.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${book.title} dihapus dari tersimpan'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Urungkan',
          textColor: _cyan,
          onPressed: () {
            setState(() {
              _books.insert(index, book);
            });
          },
        ),
      ),
    );
  }

  // Navigasi ke halaman detail buku
  void _openDetail(SavedBook book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailView(book: book.toSampleModel())),
    );
  }

  @override
  Widget build(BuildContext context) {
    final books = _filteredBooks;

    return Scaffold(
      backgroundColor: _bg,
      appBar: _buildAppBar(),
      body: books.isEmpty
          ? _buildEmptyState()
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: books.length,
              separatorBuilder: (_, _) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final book = books[index];
                return _buildBookCard(book);
              },
            ),
    );
  }

  // Header / AppBar dengan tombol kembali, judul, pencarian, dan menu
  PreferredSizeWidget _buildAppBar() {
    if (_isSearching) {
      return AppBar(
        backgroundColor: _bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            setState(() {
              _isSearching = false;
              _searchQuery = '';
              _searchController.clear();
            });
          },
        ),
        titleSpacing: 0,
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          cursorColor: _cyan,
          decoration: const InputDecoration(
            hintText: 'Cari judul buku...',
            hintStyle: TextStyle(color: _textGrey, fontSize: 14),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        ),
        actions: [
          if (_searchQuery.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: _textGrey, size: 22),
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _searchQuery = '';
                });
              },
            ),
          const SizedBox(width: 4),
        ],
      );
    }

    return AppBar(
      backgroundColor: _bg,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
      titleSpacing: 0,
      title: const Text(
        'Tersimpan',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: _textGrey, size: 24),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  // Tampilan ketika daftar buku kosong
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark_remove_rounded,
              size: 64,
              color: _subGrey.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isNotEmpty
                  ? 'Buku tidak ditemukan'
                  : 'Belum ada buku tersimpan',
              style: const TextStyle(
                color: _textGrey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Kartu buku horizontal
  Widget _buildBookCard(SavedBook book) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover buku
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(width: 90, height: 132, child: _buildCover(book)),
          ),
          const SizedBox(width: 14),
          // Detail buku di sebelah kanan
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kategori
                Text(
                  book.category,
                  style: const TextStyle(
                    color: _cyan,
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                // Judul buku
                Text(
                  book.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // Penulis
                Text(
                  book.author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: _textGrey, fontSize: 12.5),
                ),
                const SizedBox(height: 4),
                // Tahun terbit dan jumlah halaman
                Text(
                  '${book.publishedYear} · ${book.pageCount} halaman',
                  style: const TextStyle(color: _subGrey, fontSize: 11.5),
                ),
                const SizedBox(height: 10),
                // Baris aksi: tombol "Lihat buku" dan icon bookmark
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _openDetail(book),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
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
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.bookmark_rounded,
                        color: _cyan,
                        size: 24,
                      ),
                      splashRadius: 20,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      tooltip: 'Hapus dari tersimpan',
                      onPressed: () => _removeBook(book),
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

  // Tampilan gambar cover buku dengan fallback ke placeholder sederhana
  Widget _buildCover(SavedBook book) {
    if (book.coverAsset != null) {
      return Image.asset(
        book.coverAsset!,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  // Placeholder sederhana jika file asset cover belum tersedia
  Widget _buildPlaceholder() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2D4A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              color: _textGrey,
              size: 24,
            ),
            SizedBox(height: 6),
            Text(
              'Cover belum\ntersedia',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _textGrey,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
