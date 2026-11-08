import 'package:library_mobile/data/models/sample_model.dart';

// Model data untuk item riwayat membaca pengguna
class ReadingHistoryItem {
  final int id;
  final String title;
  final String author;
  final String category;
  final int publishedYear;
  final int pageCount;
  final String? coverAsset;
  final String description;
  final String finishedDate;
  final DateTime completedAt;
  final String status;

  const ReadingHistoryItem({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.publishedYear,
    required this.pageCount,
    this.coverAsset,
    this.description = '',
    required this.finishedDate,
    required this.completedAt,
    this.status = 'Selesai Dibaca',
  });

  // Konversi ke SampleModel untuk diteruskan ke halaman detail buku
  SampleModel toSampleModel() {
    return SampleModel(
      id: id,
      title: title,
      author: author,
      category: category,
      description: description,
      coverUrl: coverAsset,
      publishedYear: publishedYear,
    );
  }
}

