import 'package:flutter/material.dart';
import 'package:library_mobile/app/config/routes.dart';
import 'package:library_mobile/data/models/sample_model.dart';

// Halaman detail buku
class DetailView extends StatefulWidget {
  // Nullable karena AppRoutes.detail meneruskan arguments sebagai SampleModel?
  final SampleModel? book;

  const DetailView({super.key, this.book});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  // Skema warna konsisten dengan halaman lain
  static const Color _bg = Color(0xFF0B132B);
  static const Color _cardBg = Color(0xFF131D33);
  static const Color _cardBorder = Color(0xFF1E2D4A);
  static const Color _cyan = Color(0xFF00A8E8);
  static const Color _textGrey = Color(0xFF8E9BAE);
  static const Color _subGrey = Color(0xFF64748B);
  static const Color _chipBg = Color(0xFF1E2D4A);

  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  // Data cadangan (dummy) jika halaman dibuka lewat rute tanpa arguments
  static final SampleModel _fallbackBook = SampleModel(
    id: 1,
    title: 'Laskar Pelangi',
    author: 'Andrea Hirata',
    category: 'FIKSI INDONESIA',
    description:
        'Kisah sepuluh anak dari keluarga sederhana di Belitung yang bersekolah di SD Muhammadiyah dengan segala keterbatasannya, namun tetap semangat mengejar mimpi.',
    coverUrl: 'assets/images/laskarPelangi.jpg',
    publishedYear: 2005,
  );

  SampleModel get _book => widget.book ?? _fallbackBook;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ---------- Data turunan (dummy) ----------

 String get _yearText => _book.publishedYear.toString();

  // Dummy: tanggal terbit belum ada di model
  String get _publishedDate => '1 September $_yearText';

  String get _categoryText => _toTitleCase(_book.category);

  // Dummy: lokasi rak belum ada di model
  String get _shelfLocation => 'Rak B-12, Lantai 2 ($_categoryText)';

  String _toTitleCase(String text) {
    return text
        .toLowerCase()
        .split(' ')
        .map(
          (w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}',
        )
        .join(' ');
  }

  // ---------- Aksi ----------

  // Saat enter di kolom pencarian, buka halaman katalog
  void _submitSearch(String value) {
    FocusScope.of(context).unfocus();
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
    Navigator.of(context).pushNamed(AppRoutes.catalog);
  }

  void _notify(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  // ---------- UI ----------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderSection(),
              const SizedBox(height: 28),
              _buildSynopsis(),
              const SizedBox(height: 24),
              _buildInfoCard(),
              const SizedBox(height: 24),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final backButton = IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        if (_isSearching) {
          setState(() {
            _isSearching = false;
            _searchController.clear();
          });
        } else if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
    );

    if (_isSearching) {
      return AppBar(
        backgroundColor: _bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: backButton,
        titleSpacing: 0,
        title: TextField(
          controller: _searchController,
          autofocus: true,
          textInputAction: TextInputAction.search,
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
          onSubmitted: _submitSearch,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: _textGrey, size: 24),
            onPressed: () => _submitSearch(_searchController.text),
          ),
          const SizedBox(width: 4),
        ],
      );
    }

    return AppBar(
      backgroundColor: _bg,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: backButton,
      titleSpacing: 0,
      title: const Text(
        'Detail buku',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        // Ikon search menggantikan posisi menu (burger)
        IconButton(
          icon: const Icon(Icons.search, color: _textGrey, size: 24),
          onPressed: () => setState(() => _isSearching = true),
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  // Cover + judul, penulis, dan chip
  Widget _buildHeaderSection() {
    final book = _book;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Column(
            children: [
              Container(
                width: 130,
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _buildCover(),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Sampul buku ${book.title}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: _textGrey,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              const Text(
                'KOLEKSI PERPUSTAKAAN',
                style: TextStyle(
                  color: _textGrey,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                book.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                book.author,
                style: const TextStyle(color: _textGrey, fontSize: 15),
              ),
              const SizedBox(height: 12),
              _buildChip(_categoryText),
              const SizedBox(height: 8),
              _buildChip(_yearText),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: _chipBg,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFFCBD5E1),
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildCover() {
    final String? cover = _book.coverUrl;

    if (cover != null && cover.isNotEmpty) {
      if (cover.startsWith('http')) {
        return Image.network(
          cover,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => _buildPlaceholder(),
        );
      }
      return Image.asset(
        cover,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: _chipBg,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              color: _textGrey,
              size: 28,
            ),
            SizedBox(height: 8),
            Text(
              'Cover belum\ntersedia',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _textGrey,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSynopsis() {
    final description = _book.description;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sinopsis',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description.isEmpty ? 'Sinopsis belum tersedia.' : description,
          style: const TextStyle(color: _textGrey, fontSize: 15, height: 1.55),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informasi buku',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _cardBorder),
          ),
          child: Column(
            children: [
              _buildInfoRow('Penulis', _book.author),
              const SizedBox(height: 14),
              _buildInfoRow('Terbit', _publishedDate),
              const SizedBox(height: 14),
              const Divider(color: _cardBorder, height: 1),
              const SizedBox(height: 14),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _chipBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.location_on_outlined,
                      color: _textGrey,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Lokasi Rak',
                          style: TextStyle(color: _textGrey, fontSize: 12.5),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _shelfLocation,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 84,
          child: Text(
            label,
            style: const TextStyle(color: _subGrey, fontSize: 14),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // Tombol aksi (sementara hanya UI)
  Widget _buildActions() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton.icon(
            onPressed: () => _notify('Baca E-book'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _cyan,
              foregroundColor: const Color(0xFF0B132B),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.play_arrow_outlined, size: 22),
            label: const Text(
              'Baca E-book',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Tombol Kembali selebar tombol Baca E-book
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton(
            onPressed: () {
              if (Navigator.canPop(context)) Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: _cardBorder),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Kembali',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}