import 'package:flutter/material.dart';
import 'package:library_mobile/data/dummy/room_dummy.dart';
import 'package:library_mobile/data/models/room_model.dart';
import 'package:library_mobile/features/user/main/views/main_view.dart';
import 'package:library_mobile/features/user/main/widgets/user_bottom_nav.dart';
import 'package:library_mobile/features/user/reservation/widgets/category_tabs.dart';

// Halaman Daftar Ruangan
class RoomsView extends StatefulWidget {
  const RoomsView({super.key});

  @override
  State<RoomsView> createState() => _RoomsViewState();
}

class _RoomsViewState extends State<RoomsView> {
  // Skema warna dark mode aplikasi
  static const Color _bg = Color(0xFF0B132B);
  static const Color _cardBg = Color(0xFF131D33);
  static const Color _cardBorder = Color(0xFF1E2D4A);
  static const Color _textGrey = Color(0xFF8E9BAE);

  // Kategori ruangan yang sedang dipilih
  String _selectedCategory = RoomDummy.categories.first;

  // Filter daftar ruangan berdasarkan kategori
  List<Room> get _filteredRooms {
    if (_selectedCategory == RoomDummy.categories.first) {
      return RoomDummy.rooms;
    }
    return RoomDummy.rooms
        .where((room) => room.category == _selectedCategory)
        .toList();
  }

  void _onNavSelected(int index) {
    if (index == 0 && Navigator.canPop(context)) {
      Navigator.pop(context);
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => MainView(initialIndex: index)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final rooms = _filteredRooms;

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
        // Tombol kembali ke halaman beranda
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        title: const Text(
          'Daftar Ruangan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: UserBottomNav(
        selectedIndex: 0,
        onSelected: _onNavSelected,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            CategoryTabs(
              categories: RoomDummy.categories,
              selected: _selectedCategory,
              onChanged: (category) {
                setState(() {
                  _selectedCategory = category;
                });
              },
            ),
            const SizedBox(height: 16),
            if (rooms.isEmpty)
              _buildEmptyState()
            else
              ...rooms.map(
                (room) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _buildRoomCard(room),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Kartu ruangan
  Widget _buildRoomCard(Room room) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar Ruangan
          SizedBox(
            height: 145,
            width: double.infinity,
            child: Image.asset(
              room.imageAsset,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                color: const Color(0xFF1E2D4A),
                child: const Icon(
                  Icons.meeting_room_outlined,
                  color: _textGrey,
                  size: 40,
                ),
              ),
            ),
          ),
          // Informasi Ruangan
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Lokasi / Lantai
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: _textGrey,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      room.location,
                      style: const TextStyle(color: _textGrey, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Nama Ruangan
                Text(
                  room.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                // Daftar Fasilitas
                Wrap(
                  spacing: 14,
                  runSpacing: 6,
                  children: room.facilities.map((facility) {
                    return Text(
                      facility,
                      style: const TextStyle(color: _textGrey, fontSize: 12),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 40.0),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.meeting_room_outlined, size: 48, color: _textGrey),
            SizedBox(height: 12),
            Text(
              'Tidak ada ruangan pada kategori ini',
              style: TextStyle(color: _textGrey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
