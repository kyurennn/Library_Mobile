import 'package:flutter/material.dart';
import 'package:library_mobile/features/user/main/views/main_view.dart';
import 'package:library_mobile/features/user/main/widgets/user_bottom_nav.dart';

// Halaman Detail Lokasi Kontak Perpustakaan
class LibraryLocationDetailView extends StatelessWidget {
  final String name;
  final String subtitle;
  final String code;
  final String address;
  final String openingHours;
  final String phone;
  final String email;
  final List<String> facilities;
  final String about;

  const LibraryLocationDetailView({
    super.key,
    this.name = 'Perpustakaan Umum Bandung - Pusat',
    this.subtitle = 'Gedung Layanan Utama',
    this.code = '3204122D00000002',
    this.address = 'Jl. Merdeka No. 1 Bandung 40111 Indonesia',
    this.openingHours = 'Senin – Sabtu • 08.00 – 20.00 WIB',
    this.phone = '+62 22 0000 0000',
    this.email = 'layanan@example.id',
    this.facilities = const [
      'Ruang Baca',
      'Wi-Fi',
      'Ruang Diskusi',
      'E-Katalog',
    ],
    this.about =
        'Pusat layanan utama perpustakaan: sirkulasi, referensi, dan ruang baca umum yang terbuka untuk masyarakat.',
  });

  // Skema warna dark mode
  static const Color _bg = Color(0xFF0B132B);
  static const Color _cardBg = Color(0xFF131D33);
  static const Color _cardBorder = Color(0xFF1E2D4A);
  static const Color _cyan = Color(0xFF00A8E8);
  static const Color _textGrey = Color(0xFF8E9BAE);

  void _onNavSelected(BuildContext context, int index) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => MainView(initialIndex: index)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: const Text(
          'Lokasi Perpustakaan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: UserBottomNav(
        selectedIndex: 3,
        onSelected: (index) => _onNavSelected(context, index),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Lokasi: Icon Gedung, Nama, Subtitle
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _cyan.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.apartment_rounded,
                        color: _cyan,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: _textGrey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Baris Kode Perpustakaan
              Row(
                children: [
                  const Text(
                    'Kode',
                    style: TextStyle(
                      color: _textGrey,
                      fontSize: 12.5,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: _cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: _cardBorder),
                    ),
                    child: Text(
                      code,
                      style: const TextStyle(
                        color: _textGrey,
                        fontSize: 12,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Kartu Detail Kontak (Alamat, Jam Operasional, Telepon, Email)
              Container(
                decoration: BoxDecoration(
                  color: _cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _cardBorder),
                ),
                child: Column(
                  children: [
                    _buildInfoRow(
                      icon: Icons.location_on_outlined,
                      label: 'Alamat',
                      value: address,
                    ),
                    const Divider(
                      color: _cardBorder,
                      height: 1,
                      thickness: 1,
                    ),
                    _buildInfoRow(
                      icon: Icons.access_time_rounded,
                      label: 'Jam Operasional',
                      value: openingHours,
                    ),
                    const Divider(
                      color: _cardBorder,
                      height: 1,
                      thickness: 1,
                    ),
                    _buildInfoRow(
                      icon: Icons.phone_outlined,
                      label: 'Telepon',
                      value: phone,
                    ),
                    const Divider(
                      color: _cardBorder,
                      height: 1,
                      thickness: 1,
                    ),
                    _buildInfoRow(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: email,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Section Fasilitas
              const Text(
                'Fasilitas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: facilities.map((facility) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _cardBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _cardBorder),
                    ),
                    child: Text(
                      facility,
                      style: const TextStyle(
                        color: _textGrey,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Section Tentang Lokasi
              const Text(
                'Tentang Lokasi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                about,
                style: const TextStyle(
                  color: _textGrey,
                  fontSize: 13.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Baris informasi kontak dalam kartu
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _cyan.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: _cyan,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: _textGrey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

