import 'package:library_mobile/data/models/map_model.dart';

// Data dummy peta interaktif (sementara, sebelum terhubung ke sistem lokasi)
class MapDummy {
  MapDummy._();

  static const List<MapFloor> floors = [
    MapFloor(
      tabLabel: 'Pusat',
      zoneName: 'Pusat Layanan Sirkulasi',
      floorLabel: 'Lantai 1',
      availability: 'Tersisa 3 Loket',
      ambience: 'Suasana Ramai · Area Layanan',
    ),
    MapFloor(
      tabLabel: 'Lantai 1 · Lobi',
      zoneName: 'Lobi Utama',
      floorLabel: 'Lantai 1',
      availability: 'Tersisa 8 Kursi',
      ambience: 'Suasana Ramah · Diskusi Ringan',
    ),
    MapFloor(
      tabLabel: 'Lantai 2 · Belajar',
      zoneName: 'Zona Belajar Mandiri',
      floorLabel: 'Lantai 2',
      availability: 'Tersisa 12 Meja',
      ambience: 'Suasana Sangat Hening · Akustik Redam',
    ),
  ];

  // Indeks lantai yang aktif saat halaman dibuka
  static const int defaultFloorIndex = 2;

  static const List<MapFriend> friends = [
    MapFriend(
      name: 'Budi',
      location: 'Meja B-12',
      avatarAsset: 'assets/images/profilePic/hota.jpg',
    ),
    MapFriend(
      name: 'Sarah',
      location: 'Rak Sastra',
      avatarAsset: 'assets/images/profilePic/LS.jpg',
    ),
    MapFriend(
      name: 'Rian',
      location: 'Multimedia',
      avatarAsset: 'assets/images/profilePic/UY.jpg',
    ),
  ];
}