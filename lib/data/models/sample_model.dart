// Model data koleksi buku perpustakaan
class SampleModel {
  final int id;
  final String title;
  final String author;
  final String category;
  final String description;
  final String? coverUrl;
  final double rating;
  final int publishedYear;
  final bool isAvailable;
  final int borrowCount;

  const SampleModel({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.description,
    this.coverUrl,
    this.rating = 0.0,
    this.publishedYear = 2024,
    this.isAvailable = true,
    this.borrowCount = 0,
  });

  // Konversi dari data JSON API
  factory SampleModel.fromJson(Map<String, dynamic> json) {
    return SampleModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      author: json['author'] as String? ?? 'Penulis Tidak Diketahui',
      category: json['category'] as String? ?? 'Umum',
      description: json['description'] as String? ?? '',
      coverUrl: json['cover_url'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      publishedYear: json['published_year'] as int? ?? 2024,
      isAvailable: json['is_available'] as bool? ?? true,
      borrowCount: json['borrow_count'] as int? ?? 0,
    );
  }

  // Konversi objek ke Map JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'category': category,
      'description': description,
      'cover_url': coverUrl,
      'rating': rating,
      'published_year': publishedYear,
      'is_available': isAvailable,
      'borrow_count': borrowCount,
    };
  }

  // Salin objek dengan beberapa atribut baru
  SampleModel copyWith({
    int? id,
    String? title,
    String? author,
    String? category,
    String? description,
    String? coverUrl,
    double? rating,
    int? publishedYear,
    bool? isAvailable,
    int? borrowCount,
  }) {
    return SampleModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      category: category ?? this.category,
      description: description ?? this.description,
      coverUrl: coverUrl ?? this.coverUrl,
      rating: rating ?? this.rating,
      publishedYear: publishedYear ?? this.publishedYear,
      isAvailable: isAvailable ?? this.isAvailable,
      borrowCount: borrowCount ?? this.borrowCount,
    );
  }

  // Data tiruan untuk pengujian UI
  static List<SampleModel> get sampleList => const [
        SampleModel(
          id: 1,
          title: 'Clean Code: A Handbook of Agile Software Craftsmanship',
          author: 'Robert C. Martin',
          category: 'Teknologi',
          description:
              'Panduan legendaris tentang penulisan kode bersih, refactoring, prinsip arsitektur, dan disiplin perangkat lunak profesional.',
          coverUrl: null,
          rating: 4.8,
          publishedYear: 2008,
          isAvailable: true,
          borrowCount: 142,
        ),
        SampleModel(
          id: 2,
          title: 'Design Patterns: Elements of Reusable Object-Oriented Software',
          author: 'Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides',
          category: 'Teknologi',
          description:
              'Katalog pola desain perangkat lunak klasik (GoF) yang menjadi standar industri rekayasa perangkat lunak modern.',
          coverUrl: null,
          rating: 4.7,
          publishedYear: 1994,
          isAvailable: true,
          borrowCount: 98,
        ),
        SampleModel(
          id: 3,
          title: 'Bumi Manusia',
          author: 'Pramoedya Ananta Toer',
          category: 'Sastra & Fiksi',
          description:
              'Mahakarya sastra Indonesia yang mengisahkan perjuangan Minke di era kolonial Hindia Belanda dengan latar sosial-politik yang kuat.',
          coverUrl: null,
          rating: 4.9,
          publishedYear: 1980,
          isAvailable: false,
          borrowCount: 230,
        ),
        SampleModel(
          id: 4,
          title: 'Flutter Apprentice',
          author: 'Raywenderlich Team',
          category: 'Teknologi',
          description:
              'Panduan lengkap membangun aplikasi mobile multiplatform dengan Flutter & Dart dari dasar hingga arsitektur tingkat lanjut.',
          coverUrl: null,
          rating: 4.6,
          publishedYear: 2023,
          isAvailable: true,
          borrowCount: 75,
        ),
        SampleModel(
          id: 5,
          title: 'Laskar Pelangi',
          author: 'Andrea Hirata',
          category: 'Sastra & Fiksi',
          description:
              'Kisah inspiratif tentang sepuluh anak di Belitung yang berjuang menuntut ilmu di tengah keterbatasan fasilitas sekolah.',
          coverUrl: null,
          rating: 4.8,
          publishedYear: 2005,
          isAvailable: true,
          borrowCount: 310,
        ),
      ];
}
