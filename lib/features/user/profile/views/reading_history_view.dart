import 'package:flutter/material.dart';
import 'package:library_mobile/data/dummy/reading_history_dummy.dart';
import 'package:library_mobile/data/models/reading_history_model.dart';
import 'package:library_mobile/features/shared/detail/views/detail_view.dart';

// Halaman Riwayat Baca (Reading History Page)
class ReadingHistoryView extends StatefulWidget {
  const ReadingHistoryView({super.key});

  @override
  State<ReadingHistoryView> createState() => _ReadingHistoryViewState();
}

class _ReadingHistoryViewState extends State<ReadingHistoryView> {
  // Skema warna dark mode aplikasi
  static const Color _bg = Color(0xFF0B132B);
  static const Color _cardBg = Color(0xFF131D33);
  static const Color _cardBorder = Color(0xFF1E2D4A);
  static const Color _cyan = Color(0xFF00A8E8);
  static const Color _textGrey = Color(0xFF8E9BAE);
  static const Color _subGrey = Color(0xFF64748B);

  // Controller untuk fitur pencarian judul / penulis buku
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = '';

  late List<ReadingHistoryItem> _books;

  @override
  void initState() {
    super.initState();
    // Mengambil data dummy riwayat baca dan mengurutkan dari yang terbaru
    _books = List<ReadingHistoryItem>.from(ReadingHistoryDummy.history);
    _books.sort((a, b) => b.completedAt.compareTo(a.completedAt));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter daftar riwayat berdasarkan kata kunci pencarian
  List<ReadingHistoryItem> get _filteredBooks {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return _books;
    }
    return _books.where((book) {
      return book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query);
    }).toList();
  }

  // Navigasi ke halaman detail buku saat tombol "Lanjut Baca" ditekan
  void _openDetail(ReadingHistoryItem book) {
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
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: books.length + (!_isSearching ? 1 : 0),
              itemBuilder: (context, index) {
                // Header ringkasan aktivitas membaca (jika tidak sedang mencari)
                if (!_isSearching && index == 0) {
                  return _buildSummaryHeader(_books.length);
                }
                final bookIndex = !_isSearching ? index - 1 : index;
                final book = books[bookIndex];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14.0),
                  child: _buildBookCard(book),
                );
              },
            ),
    );
  }

  // Header / AppBar dengan tombol kembali, judul "Riwayat Baca", dan pencarian
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
            hintText: 'Cari riwayat baca...',
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
        'Riwayat Baca',
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

  // Ringkasan aktivitas membaca pengguna
  Widget _buildSummaryHeader(int totalCount) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Aktivitas Membaca',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$totalCount buku selesai dibaca',
            style: const TextStyle(
              color: _cyan,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Tampilan ketika daftar riwayat kosong
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book_rounded,
              size: 64,
              color: _subGrey.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isNotEmpty
                  ? 'Buku tidak ditemukan'
                  : 'Belum Ada Riwayat Baca',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              _searchQuery.isNotEmpty
                  ? 'Coba gunakan kata kunci pencarian yang lain.'
                  : 'Buku yang telah kamu selesaikan akan muncul di sini.',
              style: const TextStyle(
                color: _textGrey,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Kartu buku riwayat baca horizontal sesuai screenshot referensi
  Widget _buildBookCard(ReadingHistoryItem book) {
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
            child: SizedBox(
              width: 90,
              height: 132,
              child: _buildCover(book),
            ),
          ),
          const SizedBox(width: 14),
          // Detail informasi buku
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kategori
                Text(
                  book.category.toUpperCase(),
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
                // Nama penulis
                Text(
                  book.author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _textGrey,
                    fontSize: 12.5,
                  ),
                ),
                const SizedBox(height: 4),
                // Tahun terbit dan jumlah halaman
                Text(
                  '${book.publishedYear} · ${book.pageCount} halaman',
                  style: const TextStyle(
                    color: _subGrey,
                    fontSize: 11.5,
                  ),
                ),
                const SizedBox(height: 4),
                // Status dan tanggal selesai membaca
                Row(
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF10B981),
                      size: 13,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Selesai: ${book.finishedDate}',
                      style: const TextStyle(
                        color: _textGrey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Tombol "Lanjut Baca ->"
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
                            'Lanjut Baca',
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Cover image dengan fallback placeholder jika gambar tidak ditemukan
  Widget _buildCover(ReadingHistoryItem book) {
    if (book.coverAsset != null && book.coverAsset!.isNotEmpty) {
      return Image.asset(
        book.coverAsset!,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _buildPlaceholderCover(),
      );
    }
    return _buildPlaceholderCover();
  }

  Widget _buildPlaceholderCover() {
    return Container(
      color: const Color(0xFF1E2D4A),
      child: const Center(
        child: Icon(Icons.book_rounded, color: _textGrey, size: 36),
      ),
    );
  }
}

