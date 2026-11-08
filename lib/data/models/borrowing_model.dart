// Model data peminjaman buku & denda keterlambatan
import 'package:library_mobile/data/models/sample_model.dart';

// Status peminjaman buku
enum BorrowStatus { active, overdue, returned }

// Status denda sebuah peminjaman
enum FineStatus {
  none, // tidak ada denda
  running, // buku belum kembali & sudah lewat batas → denda terus bertambah
  unpaid, // buku sudah kembali terlambat, denda belum dibayar
  paid, // denda sudah lunas
}

class BorrowingItem {
  final int id;
  final String title;
  final String author;
  final String category;
  final String? coverAsset;
  final String location;
  final DateTime borrowDate;
  DateTime dueDate;
  final DateTime? returnDate;
  int extendCount;

  // Data pembayaran denda
  DateTime? finePaidDate;
  String? finePaymentMethod;

  static const int loanDays = 14; // Masa pinjam standar
  static const int maxExtend = 1; // Maksimal perpanjangan
  static const int extendDays = 7; // Lama tiap perpanjangan
  static const int finePerDay = 1000; // Denda per hari keterlambatan

  BorrowingItem({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    this.coverAsset,
    required this.location,
    required this.borrowDate,
    required this.dueDate,
    this.returnDate,
    this.extendCount = 0,
    this.finePaidDate,
    this.finePaymentMethod,
  });

  // Tanggal hari ini tanpa jam, agar hitungan hari akurat
  static DateTime get today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  // ---------- Peminjaman ----------

  BorrowStatus get status {
    if (returnDate != null) return BorrowStatus.returned;
    if (today.isAfter(dueDate)) return BorrowStatus.overdue;
    return BorrowStatus.active;
  }

  // Sisa hari (negatif jika terlambat)
  int get daysLeft => dueDate.difference(today).inDays;

  int get totalDays => dueDate.difference(borrowDate).inDays;

  // Progres masa pinjam (0.0 - 1.0)
  double get progress {
    if (totalDays <= 0) return 1;
    final used = today.difference(borrowDate).inDays;
    return (used / totalDays).clamp(0.0, 1.0);
  }

  bool get canExtend =>
      status == BorrowStatus.active && extendCount < maxExtend;

  // ---------- Denda ----------

  // Jumlah hari terlambat: dihitung sampai tanggal kembali,
  // atau sampai hari ini jika buku belum dikembalikan
  int get lateDays {
    final end = returnDate ?? today;
    final diff = end.difference(dueDate).inDays;
    return diff > 0 ? diff : 0;
  }

  int get fine => lateDays * finePerDay;

  FineStatus get fineStatus {
    if (fine == 0) return FineStatus.none;
    if (finePaidDate != null) return FineStatus.paid;
    if (returnDate == null) return FineStatus.running;
    return FineStatus.unpaid;
  }

  // Denda yang masih harus dibayar (berjalan + belum dibayar)
  int get outstandingFine =>
      fineStatus == FineStatus.running || fineStatus == FineStatus.unpaid
          ? fine
          : 0;

  // Konversi ke SampleModel untuk diteruskan ke halaman Detail
  SampleModel toSampleModel() {
    return SampleModel(
      id: id,
      title: title,
      author: author,
      category: category,
      description: '',
      coverUrl: coverAsset,
    );
  }
}
