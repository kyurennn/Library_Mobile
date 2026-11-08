import 'package:library_mobile/data/models/borrowing_model.dart';

// Data dummy peminjaman (sementara, sebelum terhubung ke API).
// Satu list yang sama dipakai ProfilePage, BorrowingListPage, dan FinePage,
// jadi perubahan (perpanjang / bayar denda) langsung terlihat di semua halaman.
class BorrowingDummy {
  BorrowingDummy._();

  static final List<BorrowingItem> items = _build();

  // Tanggal dibuat relatif terhadap hari ini supaya status selalu bervariasi
  static List<BorrowingItem> _build() {
    final today = BorrowingItem.today;
    DateTime d(int offset) => today.add(Duration(days: offset));

    return [
      BorrowingItem(
        id: 1,
        title: 'Clean Code: A Handbook of Agile Software Craftsmanship',
        author: 'Robert C. Martin',
        category: 'Teknologi',
        location: 'Athenaeum Bandung',
        borrowDate: d(-6),
        dueDate: d(8),
      ),
      BorrowingItem(
        id: 5,
        title: 'Laskar Pelangi',
        author: 'Andrea Hirata',
        category: 'Sastra & Fiksi',
        coverAsset: 'assets/images/Books/laskarPelangi.jpg',
        location: 'Athenaeum Bandung',
        borrowDate: d(-12),
        dueDate: d(2),
      ),
      // Terlambat & belum dikembalikan → denda berjalan
      BorrowingItem(
        id: 7,
        title: 'Filosofi Teras',
        author: 'Henry Manampiring',
        category: 'Pengembangan Diri',
        coverAsset: 'assets/images/Books/Book cover Filosofi Teras.png',
        location: 'Kampus Geger Kalong',
        borrowDate: d(-17),
        dueDate: d(-3),
        extendCount: 1,
      ),
      // Sudah dikembalikan terlambat 5 hari, denda belum dibayar
      BorrowingItem(
        id: 2,
        title: 'Bumi Manusia',
        author: 'Pramoedya Ananta Toer',
        category: 'Sastra & Fiksi',
        coverAsset: 'assets/images/Books/Book cover Bumi Manusia.png',
        location: 'Athenaeum Bandung',
        borrowDate: d(-30),
        dueDate: d(-16),
        returnDate: d(-11),
      ),
      // Dikembalikan tepat waktu → tanpa denda
      BorrowingItem(
        id: 9,
        title: 'Atomic Habits',
        author: 'James Clear',
        category: 'Pengembangan Diri',
        coverAsset: 'assets/images/Books/Book cover Atomic habits.png',
        location: 'Athenaeum Bandung',
        borrowDate: d(-40),
        dueDate: d(-26),
        returnDate: d(-27),
      ),
      // Dikembalikan terlambat 2 hari, denda sudah lunas
      BorrowingItem(
        id: 10,
        title: 'The Psychology of Money',
        author: 'Morgan Housel',
        category: 'Bisnis & Keuangan',
        coverAsset: 'assets/images/Books/Book cover Pyschology of money.png',
        location: 'Athenaeum Bandung',
        borrowDate: d(-60),
        dueDate: d(-46),
        returnDate: d(-44),
        finePaidDate: d(-44),
        finePaymentMethod: 'Bayar di Loket',
      ),
    ];
  }

  // ---------- Ringkasan (dipakai ProfilePage) ----------

  static int get activeCount =>
      items.where((e) => e.status == BorrowStatus.active).length;

  static int get totalOutstandingFine =>
      items.fold(0, (sum, e) => sum + e.outstandingFine);
}
