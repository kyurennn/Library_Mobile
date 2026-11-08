// Model data ruangan dan sesi reservasi

enum SessionStatus { available, booked }

class RoomSession {
  final String start;
  final String end;
  final String label;
  final SessionStatus status;

  const RoomSession({
    required this.start,
    required this.end,
    required this.label,
    this.status = SessionStatus.available,
  });

  String get timeRange => '$start - $end';

  bool get isAvailable => status == SessionStatus.available;
}

class Room {
  final String id;
  final String name;
  final String category;
  final String location;
  final String imageAsset;
  final List<String> facilities;
  final int minCapacity;
  final int maxCapacity;
  final int sessionHours;
  final int maxQuotaHours;
  final List<RoomSession> sessions;

  // Data dummy: indeks sesi yang sudah terpilih di awal (sesuai desain)
  final int? preselectedIndex;

  const Room({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.imageAsset,
    required this.facilities,
    required this.minCapacity,
    required this.maxCapacity,
    required this.sessionHours,
    required this.maxQuotaHours,
    required this.sessions,
    this.preselectedIndex,
  });

  int get availableCount => sessions.where((s) => s.isAvailable).length;

  String get capacityText => minCapacity == maxCapacity
      ? '$minCapacity Orang'
      : '$minCapacity - $maxCapacity Orang';
}