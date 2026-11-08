import 'package:flutter/material.dart';
import 'package:library_mobile/data/dummy/room_dummy.dart';
import 'package:library_mobile/data/models/room_model.dart';
import 'package:library_mobile/features/user/main/views/main_view.dart';
import 'package:library_mobile/features/user/main/widgets/user_bottom_nav.dart';
import 'package:library_mobile/features/user/reservation/widgets/category_tabs.dart';
import 'package:library_mobile/features/user/reservation/widgets/date_strip.dart';
import 'package:library_mobile/features/user/reservation/widgets/room_card.dart';
import 'package:library_mobile/features/user/reservation/widgets/session_sheet.dart';

class ReservationView extends StatefulWidget {
  const ReservationView({super.key});

  @override
  State<ReservationView> createState() => _ReservationViewState();
}

class _ReservationViewState extends State<ReservationView> {
  static const Color _bg = Color(0xFF0B132B);
  static const Color _cardBorder = Color(0xFF1E2D4A);
  static const Color _textGrey = Color(0xFF8E9BAE);

  late final List<DateTime> _days;
  late DateTime _selectedDate;
  String _category = RoomDummy.categories.first;

  @override
  void initState() {
    super.initState();
    _days = ReservationDates.upcoming(count: 5);
    _selectedDate = _days.first;
  }

  List<Room> get _filteredRooms {
    if (_category == RoomDummy.categories.first) return RoomDummy.rooms;
    return RoomDummy.rooms.where((r) => r.category == _category).toList();
  }

  // Semua tab nav kembali ke halaman utama (MainView) pada tab yang dipilih.
  // Tab Beranda (0) = kembali ke halaman awal.
  void _onNavSelected(int index) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => MainView(initialIndex: index)),
      (route) => false,
    );
  }

  void _notify(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final rooms = _filteredRooms;

    return Scaffold(
      backgroundColor: _bg,
      bottomNavigationBar: UserBottomNav(
        selectedIndex: 0,
        onSelected: _onNavSelected,
      ),
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: _cardBorder),
        ),
        // Tombol kembali ke halaman beranda
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        title: const Text(
          'Reservasi Ruangan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  _buildTitle(),
                  const SizedBox(height: 20),
                  _buildDateHeader(),
                  const SizedBox(height: 8),
                  DateStrip(
                    days: _days,
                    selected: _selectedDate,
                    onChanged: (d) => setState(() => _selectedDate = d),
                  ),
                  const SizedBox(height: 16),
                  CategoryTabs(
                    categories: RoomDummy.categories,
                    selected: _category,
                    onChanged: (c) => setState(() => _category = c),
                  ),
                  const SizedBox(height: 18),
                  if (rooms.isEmpty)
                    _buildEmptyState()
                  else
                    for (final room in rooms) ...[
                      RoomCard(
                        room: room,
                        onPressed: () => showSessionSheet(
                          context,
                          room: room,
                          date: _selectedDate,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Subjudul halaman + tombol riwayat (judul ada di app bar)
  Widget _buildTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          child: Text(
            'Pilih fasilitas & sesi belajarmu',
            style: TextStyle(color: _textGrey, fontSize: 13.5),
          ),
        ),
        TextButton.icon(
          onPressed: () => _notify('Riwayat reservasi'),
          icon: const Icon(Icons.history, color: _textGrey, size: 16),
          label: const Text(
            'Riwayat',
            style: TextStyle(color: _textGrey, fontSize: 12.5),
          ),
        ),
      ],
    );
  }

  Widget _buildDateHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Pilih Tanggal',
          style: TextStyle(color: _textGrey, fontSize: 13),
        ),
        Row(
          children: [
            const Icon(Icons.calendar_today_outlined,
                color: Color(0xFFCBD5E1), size: 14),
            const SizedBox(width: 6),
            Text(
              ReservationDates.monthYear(_selectedDate),
              style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: Text(
          'Belum ada ruangan di kategori ini',
          style: TextStyle(color: _textGrey, fontSize: 14),
        ),
      ),
    );
  }
}