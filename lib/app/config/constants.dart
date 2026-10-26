// Konstanta umum aplikasi
class AppConstants {
  AppConstants._();

  // Info aplikasi
  static const String appName = 'Library Mobile';
  static const String appTagline = 'Digital Library & Reading Hub';
  static const String appVersion = '1.0.0';

  // Dimensi padding & margin
  static const double paddingXs = 4.0;
  static const double paddingSm = 8.0;
  static const double paddingMd = 16.0;
  static const double paddingLg = 24.0;
  static const double paddingXl = 32.0;

  // Radius sudut elemen
  static const double radiusSm = 6.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;

  // Durasi animasi
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // Path aset lokal
  static const String logoPlaceholder = 'assets/icons/app_logo.png';
  static const String bookPlaceholder = 'assets/images/book_placeholder.png';
  static const String profileAvatar = 'assets/images/profile_avatar.jpg';
  static const String laskarPelangiCover = 'assets/images/laskarPelangi.jpg';
}
