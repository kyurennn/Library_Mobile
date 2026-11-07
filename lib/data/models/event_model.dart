// Model data kabar & acara perpustakaan
class EventItem {
  final String month;
  final String day;
  final String category;
  final String title;
  final String locationAndTime;

  const EventItem({
    required this.month,
    required this.day,
    required this.category,
    required this.title,
    required this.locationAndTime,
  });
}