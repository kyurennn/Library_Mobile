import 'package:flutter/material.dart';

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
                    backgroundImage: AssetImage('assets/images/profile_avatar.jpg'),
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
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined, color: Colors.blueAccent),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Peminjaman Section
              const Text(
                'Peminjaman',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildSmallCard(
                      icon: Icons.history,
                      title: 'Riwayat Baca',
                      subtitle: '14 judul selesai',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSmallCard(
                      icon: Icons.bookmark_outline,
                      title: 'Buku Tersimpan',
                      subtitle: '8 daftar bacaan',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Kontak Kami Section
              const Text(
                'Kontak Kami',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // List Lokasi Perpustakaan
              _buildLocationItem(
                name: 'Perpustakaan Umum Bandung - Pusat',
                address: 'Jl. Merdeka No. 1 Bandung 40111 Indonesia',
                code: '3204122D00000002',
                category: 'Layanan Utama',
              ),
              const SizedBox(height: 16),
              _buildLocationItem(
                name: 'Perpustakaan Umum Bandung - Taman Baca Cikapundung',
                address: 'Jl. Cikapundung Timur No. 10 Bandung Indonesia',
                code: '3204122D00000002',
                category: 'Koleksi Keluarga',
              ),
              const SizedBox(height: 16),
              _buildLocationItem(
                name: 'Perpustakaan Umum Bandung - Pojok Baca Balai Kota',
                address: 'Jl. Wastukencana No. 2 Bandung 40117 Indonesia',
                code: '3204122D00000002',
                category: 'Pustaka Umum',
              ),
              const SizedBox(height: 28),

              // Tombol Keluar
              Center(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.logout, color: Colors.redAccent),
                  label: const Text(
                    'Keluar dari Akun',
                    style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Footer App Version
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
                    Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(trailingInfo, style: TextStyle(color: trailingColor, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }

  Widget _buildSmallCard({required IconData icon, required String title, required String subtitle}) {
    return Container(
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
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildLocationItem({
    required String name,
    required String address,
    required String code,
    required String category,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: Icon(
            Icons.apartment,
            color: Colors.white70,
            size: 24,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        height: 1.25,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.white70,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                address,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    code,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '• $category',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
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
}