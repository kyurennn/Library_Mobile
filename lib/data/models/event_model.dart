class EventItem {
  final String month;
  final String day;
  final String category;
  final String title;
  final String locationAndTime;

  // Data untuk halaman detail
  final String? headline; // judul panjang di halaman detail
  final String? publishedDate; // contoh: "04 Nov 2026"
  final String? imageAsset;
  final List<String> paragraphs;

  const EventItem({
    required this.month,
    required this.day,
    required this.category,
    required this.title,
    required this.locationAndTime,
    this.headline,
    this.publishedDate,
    this.imageAsset,
    this.paragraphs = const [],
  });
}