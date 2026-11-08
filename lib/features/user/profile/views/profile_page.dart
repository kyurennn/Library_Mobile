import 'package:flutter/material.dart';
import 'package:library_mobile/features/user/profile/views/reading_history_view.dart';
import 'package:library_mobile/app/config/routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Warna latar belakang gelap
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian Header: Foto, Sapaan, & Ikon Notifikasi
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(
                      'assets/images/profile_avatar.jpg',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hi, Kane!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Library Card : #103022400147',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Peminjaman Section
              const Text(
                'Peminjaman',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildMenuCard(
                icon: Icons.menu_book,
                title: 'Daftar Peminjaman',
                subtitle: 'Daftar peminjaman buku yang...',
                trailingInfo: '1 Aktif',
                trailingColor: Colors.blue,
              ),
              const SizedBox(height: 8),
              _buildMenuCard(
                icon: Icons.account_balance_wallet_outlined,
                title: 'Denda',
                subtitle: 'Denda yang sudah dan harus...',
                trailingInfo: 'Rp 0 (Lunas)',
                trailingColor: Colors.green,
              ),
              const SizedBox(height: 24),

              // Koleksi & Aktivitas Section
              const Text(
                'Koleksi & Aktivitas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildSmallCard(
                      icon: Icons.history,
                      title: 'Riwayat Baca',
                      subtitle: '14 judul selesai',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ReadingHistoryView(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSmallCard(
                      icon: Icons.bookmark_outline,
                      title: 'Buku Tersimpan',
                      subtitle: '8 daftar bacaan',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.saved);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Kontak Kami & Lokasi Perpustakaan Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Kontak Kami',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Lokasi Perpustakaan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // List Lokasi Perpustakaan
              _buildLocationCard(
                title: 'Athenaeum Bandung',
                address: 'Jl. Telekomunikasi - Ters. Buah Batu Bandung 40257 Indonesia',
                code: '32041220800082',
                type: '• Layanan Utama',
              ),
              const SizedBox(height: 8),
              _buildLocationCard(
                title: 'Athenaeum Bandung - Kampus Geger Kalong',
                address: 'Jl. Geger Kalong No. 1 Bandung Indonesia',
                code: '32041220800082',
                type: '• Koleksi Pascasarjana',
              ),
              const SizedBox(height: 8),
              _buildLocationCard(
                title: 'Tel-U Bandung - Gedung Fakultas Kedokteran Lantai 3',
                address: 'Jl. Telekomunikasi - Ters. Buah Batu Bandung 40257 Indonesia',
                code: '32041220800082',
                type: '• Pustaka Medis',
              ),
              const SizedBox(height: 24),

              // Tombol Keluar
              Center(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.logout, color: Colors.redAccent),
                  label: const Text(
                    'Keluar dari Akun',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Footer Info Versi
              const Center(
                child: Text(
                  'Athenaeum Digital v2.4.0 • OpenLibrary Connect',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String trailingInfo,
    required Color trailingColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      trailingInfo,
                      style: TextStyle(
                        color: trailingColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }

  Widget _buildSmallCard({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, color: Colors.white70, size: 22),
                  const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCard({
    required String title,
    required String address,
    required String code,
    required String type,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.business, color: Colors.white70, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  address,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      code,
                      style: const TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      type,
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}
