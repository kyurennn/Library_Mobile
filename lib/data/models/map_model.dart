
class MapFloor {
  final String tabLabel;
  final String zoneName;
  final String floorLabel;
  final String availability;
  final String ambience;

  const MapFloor({
    required this.tabLabel,
    required this.zoneName,
    required this.floorLabel,
    required this.availability,
    required this.ambience,
  });
}


class MapFriend {
  final String name;
  final String location;
  final String? avatarAsset;

  const MapFriend({
    required this.name,
    required this.location,
    this.avatarAsset,
  });
}