import 'package:flutter/material.dart';
import 'package:library_mobile/features/main/views/main_view.dart';

enum NotificationSection {
  hariIni,
  mingguIni,
  sebelumnya,
}

// Model data notifikasi pengingat
class NotificationItem {
  final int id;
  final String category; // KLUB BUKU, WORKSHOP, LOMBA, SEMINAR, PAMERAN
  final String title;
  final String month; // NOV, DES
  final String day; // 09, 15, 21, 28, 05, 12
  final String timeAndLocation;
  final NotificationSection section;
  final String description;
  final String fullDate;
  final String fullTime;
  final String location;

  const NotificationItem({
    required this.id,
    required this.category,
    required this.title,
    required this.month,
    required this.day,
    required this.timeAndLocation,
    required this.section,
    required this.description,
    required this.fullDate,
    required this.fullTime,
    required this.location,
  });
}

// Halaman Notifikasi Pengingat
class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  // Palet warna sesuai mockup
  static const Color _bg = Color(0xFF090E1A);
  static const Color _cardBg = Color(0xFF0F1A2E);
  static const Color _cardBorder = Color(0xFF1B2A44);
  static const Color _cyan = Color(0xFF00A8E8);
  static const Color _cyanLight = Color(0xFF38BDF8);
  static const Color _textGrey = Color(0xFF8E9BAE);
  static const Color _subGrey = Color(0xFF64748B);
  static const Color _badgeBg = Color(0xFF0C2036);
  static const Color _badgeBorder = Color(0xFF1A385E);
  static const Color _barBg = Color(0xFF090E1A);
  static const Color _bottomBarBorder = Color(0xFF1E2D4A);

  // Daftar notifikasi pengingat
  static const List<NotificationItem> _notifications = [
    NotificationItem(
      id: 1,
      category: 'KLUB BUKU',
      title: "Diskusi Novel 'Bumi' karya Tere Liye",
      month: 'NOV',
      day: '09',
      timeAndLocation: 'Ruang Diskusi Komunitas • 10:00 WIB',
      section: NotificationSection.hariIni,
      fullDate: 'Senin, 09 November 2026',
      fullTime: '10:00 - 12:00 WIB',
      location: 'Ruang Diskusi Komunitas, Lt. 2',
      description:
          "Pengingat agenda diskusi novel 'Bumi' karya Tere Liye bersama Klub Buku Perpustakaan. Mengupas dunia paralel Klan Bulan, petualangan Raib, Seli, dan Ali, serta nilai filosofi persahabatan di balik kisahnya.",
    ),
    NotificationItem(
      id: 2,
      category: 'WORKSHOP',
      title: 'Workshop Menulis Kreatif',
      month: 'NOV',
      day: '15',
      timeAndLocation: 'Auditorium Lt. 2 • 13:00 WIB',
      section: NotificationSection.hariIni,
      fullDate: 'Minggu, 15 November 2026',
      fullTime: '13:00 - 16:00 WIB',
      location: 'Auditorium Lt. 2',
      description:
          'Pengingat workshop penulisan kreatif fiksi & non-fiksi bersama narasumber penulis ternama. Pelajari cara merangkai plot yang memikat, membangun karakter hidup, hingga tips menerbitkan naskah.',
    ),
    NotificationItem(
      id: 3,
      category: 'LOMBA',
      title: 'English Debate Competition',
      month: 'NOV',
      day: '21',
      timeAndLocation: 'Main Lobby • 12:00 WIB (diundur dari 10:00)',
      section: NotificationSection.hariIni,
      fullDate: 'Sabtu, 21 November 2026',
      fullTime: '12:00 - 17:00 WIB',
      location: 'Main Lobby',
      description:
          'Pengingat perubahan jadwal babak penyisihan English Debate Competition tingkat universitas. Waktu mulai diundur dari pukul 10:00 WIB menjadi pukul 12:00 WIB di Main Lobby.',
    ),
    NotificationItem(
      id: 4,
      category: 'SEMINAR',
      title: 'Seminar Literasi Digital',
      month: 'NOV',
      day: '28',
      timeAndLocation: 'Ruang Seminar • 09:00 WIB',
      section: NotificationSection.mingguIni,
      fullDate: 'Sabtu, 28 November 2026',
      fullTime: '09:00 - 12:00 WIB',
      location: 'Ruang Seminar Utama',
      description:
          'Pengingat pendaftaran Seminar Nasional Literasi Digital. Membahas etika riset akademis di era Artificial Intelligence dan verifikasi fakta ilmiah.',
    ),
    NotificationItem(
      id: 5,
      category: 'KLUB BUKU',
      title: 'Bedah Buku: Laskar Pelangi',
      month: 'DES',
      day: '05',
      timeAndLocation: 'Ruang Baca Utama • 15:00 WIB',
      section: NotificationSection.mingguIni,
      fullDate: 'Sabtu, 05 Desember 2026',
      fullTime: '15:00 - 17:30 WIB',
      location: 'Ruang Baca Utama',
      description:
          'Pengingat agenda bedah buku klasik Laskar Pelangi bersama pegiat literasi kampus di Ruang Baca Utama.',
    ),
    NotificationItem(
      id: 6,
      category: 'PAMERAN',
      title: 'Pameran Naskah Kuno Nusantara',
      month: 'DES',
      day: '12',
      timeAndLocation: 'Galeri Lt. 1 • 10:00 WIB',
      section: NotificationSection.sebelumnya,
      fullDate: 'Sabtu, 12 Desember 2026',
      fullTime: '10:00 - 18:00 WIB',
      location: 'Galeri Perpustakaan Lt. 1',
      description:
          'Pengingat eksibisi naskah dan manuskrip langka Nusantara dari abad ke-17 hingga ke-19 koleksi arsip perpustakaan pusat di Galeri Lt. 1.',
    ),
  ];

  // Navigasi bottom bar
  void _onBottomNavSelected(BuildContext context, int index) {
    if (index == 0) {
      // Kembali ke Beranda
      Navigator.of(context).pop();
    } else {
      // Pindah ke tab lain
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => MainView(initialIndex: index),
        ),
      );
    }
  }

  // Menampilkan detail pengingat saat kartu ditekan
  void _showDetailModal(BuildContext context, NotificationItem item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          decoration: const BoxDecoration(
            color: Color(0xFF0F1A2E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(
              top: BorderSide(color: _cardBorder, width: 1.5),
              left: BorderSide(color: _cardBorder, width: 1.5),
              right: BorderSide(color: _cardBorder, width: 1.5),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: _subGrey.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _badgeBg,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: _badgeBorder),
                      ),
                      child: Text(
                        item.category,
                        style: const TextStyle(
                          color: _cyanLight,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded,
                          color: _textGrey, size: 22),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A1324),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _cardBorder),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_rounded,
                              color: _cyanLight, size: 16),
                          const SizedBox(width: 10),
                          Text(
                            item.fullDate,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.access_time_rounded,
                              color: _cyanLight, size: 16),
                          const SizedBox(width: 10),
                          Text(
                            item.fullTime,
                            style: const TextStyle(
                              color: _textGrey,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined,
                              color: _cyanLight, size: 16),
                          const SizedBox(width: 10),
                          Text(
                            item.location,
                            style: const TextStyle(
                              color: _textGrey,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Keterangan Pengingat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.description,
                  style: const TextStyle(
                    color: _textGrey,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _cyan,
                      foregroundColor: const Color(0xFF090E1A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text(
                      'Tutup',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final todayList = _notifications
        .where((n) => n.section == NotificationSection.hariIni)
        .toList();
    final weekList = _notifications
        .where((n) => n.section == NotificationSection.mingguIni)
        .toList();
    final previousList = _notifications
        .where((n) => n.section == NotificationSection.sebelumnya)
        .toList();

    return Scaffold(
      backgroundColor: _bg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                // Tombol Arrow kembali ke home page di kiri atas
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _cardBg,
                      shape: BoxShape.circle,
                      border: Border.all(color: _cardBorder),
                    ),
                    child: const Icon(
                      Icons.chevron_left_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                // Judul Notifikasi & Subtitle belum dibaca
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Notifikasi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '3 belum dibaca',
                      style: TextStyle(
                        color: _textGrey,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Hari Ini
            if (todayList.isNotEmpty) ...[
              _buildSectionHeader('Hari Ini'),
              const SizedBox(height: 12),
              ...todayList.map((item) => _buildReminderCard(context, item)),
              const SizedBox(height: 16),
            ],
            // Section Minggu Ini
            if (weekList.isNotEmpty) ...[
              _buildSectionHeader('Minggu Ini'),
              const SizedBox(height: 12),
              ...weekList.map((item) => _buildReminderCard(context, item)),
              const SizedBox(height: 16),
            ],
            // Section Sebelumnya
            if (previousList.isNotEmpty) ...[
              _buildSectionHeader('Sebelumnya'),
              const SizedBox(height: 12),
              ...previousList.map((item) => _buildReminderCard(context, item)),
              const SizedBox(height: 16),
            ],
            // Footer teks
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Kamu sudah melihat semua notifikasi',
                  style: TextStyle(
                    color: _subGrey.withValues(alpha: 0.8),
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  // Section Header Judul
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Kartu pengingat (hanya teks pengingat, tanpa tombol aksi / tag tambahan)
  Widget _buildReminderCard(BuildContext context, NotificationItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorder),
      ),
      child: InkWell(
        onTap: () => _showDetailModal(context, item),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Badge Tanggal di sebelah kiri
              Container(
                width: 52,
                height: 56,
                decoration: BoxDecoration(
                  color: _badgeBg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _badgeBorder),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.month,
                      style: const TextStyle(
                        color: _cyanLight,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.day,
                      style: const TextStyle(
                        color: _cyanLight,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              // Teks informasi pengingat
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.category,
                      style: const TextStyle(
                        color: _cyanLight,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.timeAndLocation,
                      style: const TextStyle(
                        color: _textGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Bottom Navigation Bar
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _barBg,
        border: Border(
          top: BorderSide(color: _bottomBarBorder, width: 0.8),
        ),
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: _barBg,
          surfaceTintColor: Colors.transparent,
          indicatorColor: _cyan.withValues(alpha: 0.15),
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
            final selected = states.contains(WidgetState.selected);
            return TextStyle(
              color: selected ? _cyan : _subGrey,
              fontSize: 11,
              fontWeight: selected ? FontWeight.bold : FontWeight.w500,
            );
          }),
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
            final selected = states.contains(WidgetState.selected);
            return IconThemeData(
              color: selected ? _cyan : _subGrey,
              size: 24,
            );
          }),
        ),
        child: NavigationBar(
          selectedIndex: 0, // Beranda aktif
          onDestinationSelected: (idx) => _onBottomNavSelected(context, idx),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: 'Beranda',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              selectedIcon: Icon(Icons.menu_book_rounded),
              label: 'Jelajahi',
            ),
            NavigationDestination(
              icon: Icon(Icons.bookmark_border_rounded),
              selectedIcon: Icon(Icons.bookmark_rounded),
              label: 'Tersimpan',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline_rounded),
              selectedIcon: Icon(Icons.person_rounded),
              label: 'Akun',
            ),
          ],
        ),
      ),
    );
  }
}
