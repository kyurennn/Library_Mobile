// Helper pemformatan teks, tanggal, dan angka
class AppFormatters {
  AppFormatters._();

  // Tampilkan rating dengan simbol bintang (misal: 4.8 ★)
  static String formatRating(double rating) {
    return '${rating.toStringAsFixed(1)} ★';
  }

  // Format tanggal ke format lokal Indonesia (misal: 27 Okt 2026)
  static String formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  // Potong teks jika melebihi batas karakter maksimum
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  // Tambahkan titik pemisah ribuan pada angka
  static String formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }

  // Format angka ke format mata uang Rupiah
  static String formatCurrency(num amount) {
    final formatted = amount.toInt().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
    return 'Rp $formatted';
  }
}
