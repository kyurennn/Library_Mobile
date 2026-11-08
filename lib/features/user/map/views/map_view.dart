import 'package:flutter/material.dart';
import 'package:library_mobile/data/dummy/map_dummy.dart';
import 'package:library_mobile/data/models/map_model.dart';
import 'package:library_mobile/features/user/main/views/main_view.dart';
import 'package:library_mobile/features/user/main/widgets/user_bottom_nav.dart';
import 'package:library_mobile/features/user/map/widgets/campus_map.dart';
import 'package:library_mobile/features/user/map/widgets/friend_avatar.dart';

// Halaman peta interaktif kampus
class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  static const Color _bg = Color(0xFF0B132B);
  static const Color _cardBg = Color(0xFF131D33);
  static const Color _cardBorder = Color(0xFF1E2D4A);
  static const Color _cyan = Color(0xFF00A8E8);
  static const Color _green = Color(0xFF10B981);
  static const Color _textGrey = Color(0xFF8E9BAE);

  int _floorIndex = MapDummy.defaultFloorIndex;

  MapFloor get _floor => MapDummy.floors[_floorIndex];

  // Semua tab nav kembali ke halaman utama (MainView) pada tab yang dipilih
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
    return Scaffold(
      backgroundColor: _bg,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildNavigateBar(),
          UserBottomNav(selectedIndex: 0, onSelected: _onNavSelected),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: _buildHeader(),
            ),
            const Divider(color: _cardBorder, height: 1),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleRow(),
                    const SizedBox(height: 10),
                    _buildSearchBar(),
                    const SizedBox(height: 14),
                    _buildFloorTabs(),
                    const SizedBox(height: 12),
                    CampusMap(friends: MapDummy.friends),
                    const SizedBox(height: 16),
                    _buildZoneCard(),
                    const SizedBox(height: 22),
                    _buildFriendsSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header: avatar pengguna, nama, ID kartu, dan notifikasi
  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _cyan.withValues(alpha: 0.5), width: 1.8),
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
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, Kane!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Library Card : #103022400141',
                style: TextStyle(color: _textGrey, fontSize: 12),
              ),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: () => _notify('Tidak ada notifikasi baru'),
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: _cyan,
                size: 26,
              ),
              splashRadius: 22,
            ),
            Positioned(
              top: 10,
              right: 12,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF3B30),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Baris judul: tombol kembali, judul, layer, dan lokasi saya
  Widget _buildTitleRow() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        const SizedBox(width: 4),
        const Expanded(
          child: Text(
            'Peta Interaktif Kampus',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.layers_outlined, color: Colors.white, size: 22),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          onPressed: () => _notify('Lapisan peta'),
        ),
        IconButton(
          icon: const Icon(
            Icons.my_location_outlined,
            color: Colors.white,
            size: 22,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          onPressed: () => _notify('Lokasi saya'),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF94A3B8), size: 22),
          const SizedBox(width: 10),
          const Expanded(
            child: TextField(
              style: TextStyle(color: Color(0xFF0B132B), fontSize: 14),
              cursorColor: _cyan,
              decoration: InputDecoration(
                hintText: 'Cari zona, rak buku, atau teman...',
                hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.tune_rounded, color: Color(0xFF94A3B8), size: 20),
        ],
      ),
    );
  }

  // Tab lantai yang bisa digeser horizontal
  Widget _buildFloorTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          for (int i = 0; i < MapDummy.floors.length; i++) ...[
            _buildFloorChip(i),
            if (i != MapDummy.floors.length - 1) const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }

  Widget _buildFloorChip(int index) {
    final selected = index == _floorIndex;

    return InkWell(
      onTap: () => setState(() => _floorIndex = index),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? _cyan.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? _cyan.withValues(alpha: 0.6) : _cardBorder,
          ),
        ),
        child: Text(
          MapDummy.floors[index].tabLabel,
          style: TextStyle(
            color: selected ? Colors.white : _textGrey,
            fontSize: 13,
            fontWeight: selected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // Kartu informasi zona yang dipilih
  Widget _buildZoneCard() {
    final floor = _floor;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ZONA TERPILIH',
                  style: TextStyle(
                    color: _cyan,
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  floor.zoneName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 1),
                      child: Icon(
                        Icons.volume_off_outlined,
                        color: _textGrey,
                        size: 15,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        floor.ambience,
                        style: const TextStyle(
                          color: _textGrey,
                          fontSize: 12.5,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2D4A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  floor.floorLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                floor.availability,
                style: const TextStyle(
                  color: _green,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Daftar teman di perpustakaan dengan foto profil bulat
  Widget _buildFriendsSection() {
    final friends = MapDummy.friends;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.people_outline, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Teman di Perpustakaan (${friends.length})',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () => _notify('Daftar teman diperbarui'),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Segarkan',
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
        SizedBox(
          height: 92,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: friends.length,
            separatorBuilder: (_, _) => const SizedBox(width: 18),
            itemBuilder: (_, i) => _buildFriendItem(friends[i]),
          ),
        ),
      ],
    );
  }

  Widget _buildFriendItem(MapFriend friend) {
    return Tooltip(
      message: friend.name,
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            FriendAvatar(friend: friend, size: 56, showOnline: true),
            const SizedBox(height: 8),
            Text(
              friend.location,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(color: _textGrey, fontSize: 11.5),
            ),
          ],
        ),
      ),
    );
  }

  // Tombol navigasi rute di atas bottom nav
  Widget _buildNavigateBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      decoration: const BoxDecoration(
        color: _bg,
        border: Border(top: BorderSide(color: _cardBorder, width: 0.8)),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () => _notify('Mulai navigasi rute'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _cyan,
                  foregroundColor: const Color(0xFF0B132B),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.directions_walk_rounded, size: 20),
                label: const Text(
                  'Mulai Navigasi Rute',
                  style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 48,
            height: 48,
            child: OutlinedButton(
              onPressed: () => _notify('Tandai lokasi'),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                side: const BorderSide(color: _cardBorder),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Icon(
                Icons.pin_drop_outlined,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}