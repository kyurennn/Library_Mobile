import 'package:flutter/material.dart';
import 'package:library_mobile/app/config/routes.dart';
import 'package:library_mobile/data/dummy/event_dummy.dart';
import 'package:library_mobile/data/models/event_model.dart';
import 'package:library_mobile/features/user/main/views/main_view.dart';

class HomeView extends StatelessWidget {
  // Dipanggil saat foto profil ditekan (mis. pindah ke tab Akun)
  final VoidCallback? onProfileTap;

  const HomeView({super.key, this.onProfileTap});

  // Skema warna dark mode
  static const Color _bg = Color(0xFF0B132B);
  static const Color _cardBg = Color(0xFF131D33);
  static const Color _cardBorder = Color(0xFF1E2D4A);
  static const Color _cyan = Color(0xFF00A8E8);
  static const Color _green = Color(0xFF10B981);
  static const Color _gold = Color(0xFFFBBF24);
  static const Color _textGrey = Color(0xFF8E9BAE);

  // Daftar agenda kabar & acara (data bersama dengan halaman Kabar & Acara)
  static const List<EventItem> _events = EventDummy.events;

  // Menu pintasan layanan
  static const List<_ServiceItem> _services = [
    _ServiceItem(
      label: 'Ruangan',
      icon: Icons.meeting_room_outlined,
      route: AppRoutes.rooms,
    ),
    _ServiceItem(
      label: 'Reservasi',
      icon: Icons.calendar_month_outlined,
      route: AppRoutes.reservation,
    ),
    _ServiceItem(
      label: 'Kembalikan',
      icon: Icons.assignment_return_outlined,
      message: 'Pengembalian',
    ),
    _ServiceItem(
      label: 'Katalog',
      icon: Icons.search_rounded,
      route: AppRoutes.catalog,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                _buildHeader(context),
                const SizedBox(height: 22),
                _buildServiceMenu(context),
                const SizedBox(height: 22),
                _buildActiveLoanCard(context),
                const SizedBox(height: 24),
                _buildMapCard(context),
                const SizedBox(height: 24),
                _buildEventList(context),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleProfileTap(BuildContext context) {
    if (onProfileTap != null) {
      onProfileTap!();
    } else {
      MainView.switchTab(context, 3);
    }
  }

  // Header: avatar pengguna, nama, ID kartu, dan notifikasi
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
                GestureDetector(
          onTap: () => _handleProfileTap(context),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _cyan.withValues(alpha: 0.5),
                  width: 1.8,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile_avatar.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      const Icon(Icons.person, color: Colors.white, size: 26),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Baris menu layanan
  Widget _buildServiceMenu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Service',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _services
              .map((item) => _buildServiceItem(context, item))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildServiceItem(BuildContext context, _ServiceItem item) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (item.route != null) {
            Navigator.of(context).pushNamed(item.route!);
          } else if (item.message != null) {
            _notify(context, item.message!);
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: _cyan,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: _cyan.withValues(alpha: 0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(item.icon, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              item.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Kartu buku yang sedang dipinjam
  Widget _buildActiveLoanCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              width: 48,
              height: 66,
              child: Image.asset(
                'assets/images/Books/laskarPelangi.jpg',
                width: 48,
                height: 66,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  width: 48,
                  height: 66,
                  color: const Color(0xFF1E2D4A),
                  child: const Icon(
                    Icons.menu_book_rounded,
                    color: Colors.white70,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: _green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'SEDANG DIPINJAM',
                      style: TextStyle(
                        color: _green,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Laskar Pelangi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: const TextSpan(
                    text: 'Kembalikan dalam ',
                    style: TextStyle(color: _textGrey, fontSize: 12),
                    children: [
                      TextSpan(
                        text: '4 hari',
                        style: TextStyle(
                          color: _gold,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () => _notify(context, 'Permintaan perpanjangan diajukan'),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF0F2644),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF0284C7).withValues(alpha: 0.5),
                  width: 1.2,
                ),
              ),
              child: const Text(
                'Perpanjang',
                style: TextStyle(
                  color: _cyan,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Bagian kartu peta & denah perpustakaan
  Widget _buildMapCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Peta & Fasilitas',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 190,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF0E1729),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  border: Border(
                    bottom: BorderSide(color: _cardBorder, width: 1),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  'assets/images/map/hpmap.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const Center(
                    child: Text(
                      'Coming Soon',
                      style: TextStyle(
                        color: _cyan,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Library Map',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: _green.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _green.withValues(alpha: 0.4),
                              width: 1,
                            ),
                          ),
                          child: const Text(
                            'Open',
                            style: TextStyle(
                              color: _green,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Temukan lokasi rak buku, auditorium acara, ruang baca dan lokasi teman.',
                      style: TextStyle(
                        color: _textGrey,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 14),
                    InkWell(
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.map),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 44,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F2644).withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: _cyan.withValues(alpha: 0.5),
                            width: 1.2,
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: _cyan,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Open Map',
                              style: TextStyle(
                                color: _cyan,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
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

  // Bagian daftar agenda & kabar perpustakaan
  Widget _buildEventList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Kabar & Acara',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.events),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Lihat Semua',
                style: TextStyle(
                  color: _cyan,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _events.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final event = _events[index];
            return InkWell(
              onTap: () => Navigator.of(
                context,
              ).pushNamed(AppRoutes.eventDetail, arguments: event),
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _cardBg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _cardBorder),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0E223D),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFF1E3A60),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            event.month,
                            style: const TextStyle(
                              color: _cyan,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            event.day,
                            style: const TextStyle(
                              color: _cyan,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.category,
                            style: const TextStyle(
                              color: _cyan,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            event.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            event.locationAndTime,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: _textGrey,
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xFF64748B),
                      size: 14,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _notify(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }
}

class _ServiceItem {
  final String label;
  final IconData icon;
  final String? route;
  final String? message;

  const _ServiceItem({
    required this.label,
    required this.icon,
    this.route,
    this.message,
  });
}