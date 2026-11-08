import 'package:flutter/material.dart';
import 'package:library_mobile/data/dummy/event_dummy.dart';
import 'package:library_mobile/data/models/event_model.dart';

// Halaman detail kabar & acara
class EventDetailView extends StatelessWidget {
  // Nullable karena AppRoutes meneruskan arguments sebagai EventItem?
  final EventItem? event;

  const EventDetailView({super.key, this.event});

  static const Color _bg = Color(0xFF0B132B);
  static const Color _cardBorder = Color(0xFF1E2D4A);
  static const Color _textGrey = Color(0xFF8E9BAE);

  // Data cadangan jika halaman dibuka tanpa arguments
  EventItem get _event => event ?? EventDummy.events.first;

  @override
  Widget build(BuildContext context) {
    final e = _event;
    final headline = e.headline ?? e.title;

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: _cardBorder),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        title: const Text(
          'Kabar & Acara',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headline,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
              if (e.publishedDate != null) ...[
                const SizedBox(height: 12),
                Text(
                  e.publishedDate!,
                  style: const TextStyle(color: _textGrey, fontSize: 12.5),
                ),
              ],
              const SizedBox(height: 16),
              _buildImage(e),
              const SizedBox(height: 18),
              if (e.paragraphs.isEmpty)
                const Text(
                  'Deskripsi acara belum tersedia.',
                  style: TextStyle(color: _textGrey, fontSize: 13),
                )
              else
                for (final p in e.paragraphs) ...[
                  Text(
                    p,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(EventItem e) {
    final asset = e.imageAsset;
    if (asset == null) return const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 16 / 11,
        child: Image.asset(
          asset,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => Container(
            color: const Color(0xFF131D33),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_not_supported_outlined,
                  color: _textGrey,
                  size: 32,
                ),
                SizedBox(height: 8),
                Text(
                  'Gambar belum tersedia',
                  style: TextStyle(color: _textGrey, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}