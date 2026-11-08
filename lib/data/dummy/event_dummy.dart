import 'package:library_mobile/data/models/event_model.dart';

// Data dummy kabar & acara (sementara, sebelum terhubung ke API)
class EventDummy {
  EventDummy._();

  static const List<EventItem> events = [
    EventItem(
      month: 'OCT',
      day: '30',
      category: 'LITERACY EVENT',
      title: 'Night at Open Library "Muringkak!"',
      locationAndTime: 'Area Quite Zone Open Library • 17:00 WIB',
      headline:
          'Keseruan Night at Open Library “Muringkak!” Hadirkan Pengalaman Literasi Budaya yang Berbeda',
      publishedDate: '04 Nov 2026',
      imageAsset: 'assets/images/Events/muringkak.png',
      paragraphs: [
        'Bandung, 30 Oktober 2026 – Telkom University Open Library memasuki rangkaian acara yang ke-8 dari Literacy Event 2026. Dengan menghadirkan kegiatan bertema Cultural Literacy melalui acara Night at Open Library “Muringkak!” yang dalam bahasa sunda berarti “Merinding!” dengan mengangkat topik “Misteri Urban Legend dan Kisah Rakyat dalam Ingatan Kolektif”.',
        'Kegiatan ini berlangsung pada Jumat, 30 Oktober 2026, pukul 17.00 WIB di Area Quite Zone Open Library, Gedung Manterawu Lantai 5, Telkom University. Acara ini mengangkat pembahasan mengenai urban legend, kisah mistis, dan fenomena konten horor dari berbagai perspektif, mulai dari budaya, filsafat, teknologi, hingga perkembangan industri kreatif.',
        'Kegiatan ini menghadirkan tiga narasumber dengan latar belakang dan keahlian yang berbeda. Dr. Stephanus Djunatan akan membahas mistisisme dalam budaya Sunda, yang berkaitan dengan kepercayaan dan kisah mistis dalam kehidupan masyarakat. Qbiel The Southlander (@qibiel.23), seorang kreator konten horor berbasis teknologi, akan membahas proses produksi konten horor di era digital. Sementara itu, Rizky Ramadhan, Ph.D., akan mengulas komersialisasi dan konsumsi konten horor, termasuk bagaimana kisah-kisah mistis dapat berkembang menjadi bagian dari budaya populer dan industri kreatif.',
        'Sebelum acara dimulai, para peserta disambut dengan beragam sajian makanan dan minuman tradisional, termasuk bandrek hangat yang semakin menambah kenyamanan di tengah suasana malam. Tak hanya itu, Open Library juga menghadirkan sejumlah karakter hantu khas Indonesia dengan penampilan menyeramkan dan penghayatan peran yang total. Kehadiran mereka semakin menghidupkan suasana acara, sekaligus memberikan pengalaman menegangkan yang sukses membuat para peserta merinding. Pembahasan mengenai urban legend dan konten horror dapat memperluas pemahaman peserta, bahwa literasi tidak hanya berkaitan dengan aktivitas membaca dan menulis, tetapi juga kemampuan memahami budaya, mengkritisi informasi, serta melihat fenomena horor dari berbagai sudut pandang. Kegiatan ini menjadi salah satu bentuk pengembangan literasi budaya yang dikemas secara menarik, interaktif, dan relevan dengan perkembangan zaman.',
      ],
    ),
    EventItem(
      month: 'MEI',
      day: '18',
      category: 'KLUB BUKU',
      title: "Diskusi Novel 'Bumi' karya Tere Liye",
      locationAndTime: 'Ruang Diskusi Komunitas • 10:00 WIB',
      headline: "Diskusi Novel 'Bumi' karya Tere Liye Bersama Klub Buku",
      publishedDate: '10 Mei 2026',
      paragraphs: [
        'Bandung, 18 Mei 2026 – Klub Buku Open Library mengajak seluruh civitas akademika untuk berdiskusi tentang novel “Bumi” karya Tere Liye di Ruang Diskusi Komunitas.',
        'Diskusi dimulai pukul 10.00 WIB dan terbuka untuk umum. Peserta akan membahas tokoh, alur cerita, serta pesan yang dapat dipetik dari petualangan Raib, Seli, dan Ali di dunia paralel.',
        'Peserta dipersilakan membawa salinan bukunya sendiri. Salinan juga tersedia untuk dipinjam di Open Library selama acara berlangsung.',
      ],
    ),
    EventItem(
      month: 'OCT',
      day: '01',
      category: 'KLUB BUKU',
      title: 'Happy Halloween',
      locationAndTime: 'Main Lobby • 14:00 WIB',
      headline: 'Happy Halloween di Main Lobby Open Library',
      publishedDate: '25 Okt 2026',
      paragraphs: [
        'Bandung, 1 Oktober 2026 – Open Library memeriahkan bulan Oktober dengan acara Happy Halloween yang digelar di Main Lobby pukul 14.00 WIB.',
        'Pengunjung diajak membaca kisah-kisah misteri dan menikmati dekorasi bertema Halloween. Peserta yang datang dengan kostum terbaik berkesempatan mendapatkan hadiah menarik.',
      ],
    ),
    EventItem(
      month: 'OCT',
      day: '21',
      category: 'KLUB BUKU',
      title: 'English Debate Competition',
      locationAndTime: 'Main Lobby • 12:00 WIB',
      headline: 'English Debate Competition Antar Mahasiswa',
      publishedDate: '15 Okt 2026',
      paragraphs: [
        'Bandung, 21 Oktober 2026 – Open Library menggelar English Debate Competition yang diikuti mahasiswa dari berbagai program studi. Acara berlangsung di Main Lobby mulai pukul 12.00 WIB.',
        'Setiap tim akan beradu argumen dalam bahasa Inggris mengenai isu-isu terkini seputar literasi dan teknologi. Para juri berasal dari dosen dan praktisi bahasa.',
        'Kompetisi ini bertujuan melatih kemampuan berpikir kritis dan berbicara di depan umum. Pemenang akan mendapatkan sertifikat dan hadiah dari Open Library.',
      ],
    ),
  ];
}