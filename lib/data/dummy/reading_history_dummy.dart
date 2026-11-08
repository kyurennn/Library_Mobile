import 'package:library_mobile/data/models/reading_history_model.dart';

// Data dummy riwayat baca pengguna (diurutkan dari aktivitas membaca terbaru)
class ReadingHistoryDummy {
  ReadingHistoryDummy._();

  static final List<ReadingHistoryItem> history = [
    ReadingHistoryItem(
      id: 1,
      title: 'Laskar Pelangi',
      author: 'Andrea Hirata',
      category: 'FIKSI INDONESIA',
      publishedYear: 2005,
      pageCount: 529,
      coverAsset: 'assets/images/Books/laskarPelangi.jpg',
      description:
          'Kisah inspiratif tentang sepuluh anak di Belitung yang berjuang menuntut ilmu di tengah keterbatasan fasilitas sekolah.',
      finishedDate: '12 Oktober 2026',
      completedAt: DateTime(2026, 10, 12),
      status: 'Selesai Dibaca',
    ),
    ReadingHistoryItem(
      id: 2,
      title: 'Negeri 5 Menara',
      author: 'Leila S. Chudori',
      category: 'FIKSI INDONESIA',
      publishedYear: 2017,
      pageCount: 555,
      coverAsset: 'assets/images/Books/Book cover (1).png',
      description:
          'Kisah persahabatan enam santri dari berbagai daerah di Indonesia yang menuntut ilmu di Pondok Madani.',
      finishedDate: '28 September 2026',
      completedAt: DateTime(2026, 9, 28),
      status: 'Selesai Dibaca',
    ),
    ReadingHistoryItem(
      id: 3,
      title: 'Atomic Habits',
      author: 'James Clear',
      category: 'SELF-HELP BOOK',
      publishedYear: 2018,
      pageCount: 315,
      coverAsset: 'assets/images/Books/Book cover Atomic habtis.png',
      description:
          'Perubahan kecil yang memberikan hasil luar biasa dalam membangun kebiasaan baik dan mematahkan kebiasaan buruk.',
      finishedDate: '15 September 2026',
      completedAt: DateTime(2026, 9, 15),
      status: 'Selesai Dibaca',
    ),
    ReadingHistoryItem(
      id: 4,
      title: 'The Psychology of Money',
      author: 'Morgan Housel',
      category: 'SELF-HELP BOOK',
      publishedYear: 2020,
      pageCount: 255,
      coverAsset: 'assets/images/Books/Book cover Pyschology of money.png',
      description:
          'Pelajaran abadi mengenai kekayaan, ketamakan, dan kebahagiaan dalam mengambil keputusan finansial.',
      finishedDate: '2 Agustus 2026',
      completedAt: DateTime(2026, 8, 2),
      status: 'Selesai Dibaca',
    ),
    ReadingHistoryItem(
      id: 5,
      title: 'Bumi Manusia',
      author: 'Pramoedya Ananta Toer',
      category: 'SASTRA INDONESIA',
      publishedYear: 2018,
      pageCount: 535,
      coverAsset: 'assets/images/Books/Book cover Bumi Manusia.png',
      description:
          'Roman sejarah awal abad ke-20 yang mengisahkan pergulatan Minke melawan feodalisme dan kolonialisme.',
      finishedDate: '20 Juli 2026',
      completedAt: DateTime(2026, 7, 20),
      status: 'Selesai Dibaca',
    ),
    ReadingHistoryItem(
      id: 6,
      title: 'Filosofi Teras',
      author: 'Henry Manampiring',
      category: 'PENGEMBANGAN DIRI',
      publishedYear: 2019,
      pageCount: 346,
      coverAsset: 'assets/images/Books/Book cover Filosofi Teras.png',
      description:
          'Penerapan filsafat Stoisisme kuno untuk menghadapi kekhawatiran dan emosi negatif di era modern.',
      finishedDate: '11 Juli 2026',
      completedAt: DateTime(2026, 7, 11),
      status: 'Selesai Dibaca',
    ),
    ReadingHistoryItem(
      id: 7,
      title: 'Perahu Kertas',
      author: 'Dee Lestari',
      category: 'FIKSI REMAJA',
      publishedYear: 2012,
      pageCount: 444,
      coverAsset: 'assets/images/Books/Book cover Perahu Kertas.png',
      description:
          'Kisah perjalanan dua anak manusia, Kugy dan Keenan, dalam menemukan mimpi dan takdir cinta mereka.',
      finishedDate: '25 Juni 2026',
      completedAt: DateTime(2026, 6, 25),
      status: 'Selesai Dibaca',
    ),
  ];
}

