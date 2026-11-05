// Endpoint REST API backend perpustakaan
class ApiEndpoints {
  ApiEndpoints._();

  // URL dasar server API
  static const String baseUrl = 'https://api.library.example.com/api/v1';

  // Autentikasi pengguna
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
  static const String logout = '$baseUrl/auth/logout';
  static const String profile = '$baseUrl/auth/profile';

  // Katalog dan kategori buku
  static const String books = '$baseUrl/books';
  static const String categories = '$baseUrl/books/categories';
  static const String searchBooks = '$baseUrl/books/search';
  static String bookDetail(int id) => '$baseUrl/books/$id';

  // Transaksi peminjaman dan pengembalian
  static const String loans = '$baseUrl/loans';
  static const String activeLoans = '$baseUrl/loans/active';
  static const String loanHistory = '$baseUrl/loans/history';
  static String borrowBook(int id) => '$baseUrl/loans/borrow/$id';
  static String returnBook(int id) => '$baseUrl/loans/return/$id';
}
