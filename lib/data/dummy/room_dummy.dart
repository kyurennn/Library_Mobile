import 'package:library_mobile/data/models/room_model.dart';

// Data dummy ruangan (sementara, sebelum terhubung ke API)
class RoomDummy {
  RoomDummy._();

  static const List<String> categories = [
    'Semua',
    'Ruang Diskusi',
    'Podcast Studio',
    'Silent Box',
  ];

  static const List<Room> rooms = [
    Room(
      id: 'room-3a',
      name: 'Ruang Diskusi Kolaboratif 3A',
      category: 'Ruang Diskusi',
      location: 'Lantai 2 · Sayap Timur',
      imageAsset: 'assets/images/Rooms/Ruang3A.png',
      facilities: ['Smart TV 55"', 'Whiteboard', 'AC Central', 'Power Outlet'],
      minCapacity: 4,
      maxCapacity: 8,
      sessionHours: 2,
      maxQuotaHours: 2,
      preselectedIndex: 2,
      sessions: [
        RoomSession(start: '09:00', end: '11:00', label: 'Sesi Pagi'),
        RoomSession(start: '13:00', end: '15:00', label: 'Sesi Siang'),
        RoomSession(start: '15:30', end: '17:30', label: 'Sesi Sore'),
      ],
    ),
    Room(
      id: 'podcast-studio',
      name: 'Podcast Studio',
      category: 'Podcast Studio',
      location: 'Lantai 3 · Creative Hub',
      imageAsset: 'assets/images/Rooms/Podcast.png',
      facilities: ['Soundproof', 'Rode Mic', 'Ring Light'],
      minCapacity: 1,
      maxCapacity: 3,
      sessionHours: 2,
      maxQuotaHours: 2,
      sessions: [
        RoomSession(start: '09:00', end: '11:00', label: 'Sesi Pagi'),
        RoomSession(
          start: '11:30',
          end: '13:30',
          label: 'Sesi Tengah',
          status: SessionStatus.booked,
        ),
        RoomSession(start: '14:00', end: '16:00', label: 'Sesi Siang'),
        RoomSession(start: '16:30', end: '18:30', label: 'Sesi Sore'),
      ],
    ),
    Room(
      id: 'silent-box-1',
      name: 'Silent Box',
      category: 'Silent Box',
      location: 'Lantai 4 · Sayap Barat',
      imageAsset: 'assets/images/Rooms/SilentBox.jpg',
      facilities: ['Soundproof', 'Power Charge', 'Ring Light', 'Sofa'],
      minCapacity: 1,
      maxCapacity: 2,
      sessionHours: 2,
      maxQuotaHours: 2,
      sessions: [
        RoomSession(start: '09:00', end: '11:00', label: 'Sesi Pagi'),
        RoomSession(start: '13:00', end: '15:00', label: 'Sesi Siang'),
        RoomSession(start: '15:30', end: '17:30', label: 'Sesi Sore'),
      ],
    ),
    Room(
      id: 'silent-box-2',
      name: 'Silent Box',
      category: 'Silent Box',
      location: 'Lantai 4 · Sayap Barat',
      imageAsset: 'assets/images/Rooms/SilentBox.jpg',
      facilities: ['Soundproof', 'Power Charge', 'Ring Light', 'Sofa'],
      minCapacity: 1,
      maxCapacity: 2,
      sessionHours: 2,
      maxQuotaHours: 2,
      sessions: [
        RoomSession(start: '09:00', end: '11:00', label: 'Sesi Pagi'),
        RoomSession(start: '13:00', end: '15:00', label: 'Sesi Siang'),
      ],
    ),
  ];
}
