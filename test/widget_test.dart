import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:library_mobile/app/app.dart';

void main() {
  testWidgets('App smoke test initializes and displays Beranda tab',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    // Verifikasi aplikasi berhasil memuat tab navigasi Beranda
    expect(find.text('Beranda'), findsWidgets);
  });

  testWidgets('App displays Tersimpan navigation destination',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    // Verifikasi menu Tersimpan tersedia pada bottom navigation
    expect(find.text('Tersimpan'), findsWidgets);
  });

  testWidgets('Jelajahi page displays search bar, filter chips, and featured book',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    // Klik tab navigasi Jelajahi
    await tester.tap(find.text('Jelajahi'));
    await tester.pumpAndSettle();

    // Verifikasi elemen halaman Jelajahi
    expect(find.text('Pencarian'), findsOneWidget);
    expect(find.text('Temukan bacaanmu'), findsOneWidget);
    expect(find.text('Cerita baru, sudut pandang baru.'), findsOneWidget);
    expect(find.text('Cari judul atau penulis'), findsOneWidget);

    // Verifikasi filter kategori
    expect(find.text('Semua'), findsOneWidget);
    expect(find.text('Fiksi'), findsOneWidget);
    expect(find.text('Nonfiksi'), findsOneWidget);
    expect(find.text('Biografi'), findsOneWidget);

    // Verifikasi pilihan pustakawan
    expect(find.text('Pilihan pustakawan'), findsOneWidget);
    expect(find.text('Laskar Pelangi'), findsWidgets);

    // Verifikasi dropdown Populer
    expect(find.text('Populer'), findsOneWidget);
  });

  testWidgets('Back arrow in Jelajahi navigates back to Home page',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    // Pindah ke tab Jelajahi
    await tester.tap(find.text('Jelajahi'));
    await tester.pumpAndSettle();
    expect(find.text('Temukan bacaanmu'), findsOneWidget);

    // Klik tombol panah kembali (kiri atas)
    final backArrowFinder = find.byTooltip('Kembali ke Beranda');
    expect(backArrowFinder, findsOneWidget);
    await tester.tap(backArrowFinder);
    await tester.pumpAndSettle();

    // Verifikasi kembali ke Beranda (misal: teks 'Hi, Kane!')
    expect(find.text('Hi, Kane!'), findsOneWidget);
  });

  testWidgets('Category filters work for Fiksi, Nonfiksi, and Biografi',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    // Buka tab Jelajahi
    await tester.tap(find.text('Jelajahi'));
    await tester.pumpAndSettle();

    // 1. Filter Fiksi
    await tester.tap(find.text('Fiksi'));
    await tester.pumpAndSettle();
    expect(find.text('Negara 5 Menara'), findsOneWidget);
    expect(find.text('Bumi Manusia'), findsOneWidget);
    expect(find.text('Perahu Kertas'), findsOneWidget);
    expect(find.text('Filosofi Teras'), findsNothing);

    // 2. Filter Nonfiksi
    await tester.tap(find.text('Nonfiksi'));
    await tester.pumpAndSettle();
    expect(find.text('Filosofi Teras'), findsOneWidget);
    expect(find.text('Negara 5 Menara'), findsNothing);

    // 3. Filter Biografi
    await tester.tap(find.text('Biografi'));
    await tester.pumpAndSettle();
    expect(find.text('Habibie & Ainun'), findsOneWidget);
    expect(find.text('Bung Karno'), findsOneWidget);
    expect(find.text('Negara 5 Menara'), findsNothing);

    // 4. Reset ke Semua
    await tester.tap(find.text('Semua'));
    await tester.pumpAndSettle();
    expect(find.text('Negara 5 Menara'), findsOneWidget);
  });

  testWidgets('Dropdown Populer and Terbaru switches sort mode',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    // Buka tab Jelajahi
    await tester.tap(find.text('Jelajahi'));
    await tester.pumpAndSettle();

    // Scroll agar dropdown Populer terlihat jelas di atas bottom navigation bar
    await tester.ensureVisible(find.text('Populer'));
    await tester.pumpAndSettle();

    // Verifikasi teks dropdown awal adalah 'Populer'
    expect(find.text('Populer'), findsOneWidget);

    // Buka menu dropdown
    await tester.tap(find.text('Populer'));
    await tester.pumpAndSettle();

    // Verifikasi opsi 'Terbaru' muncul pada menu dropdown
    expect(find.text('Terbaru'), findsOneWidget);

    // Pilih 'Terbaru'
    await tester.tap(find.text('Terbaru'));
    await tester.pumpAndSettle();

    // Verifikasi dropdown sekarang menampilkan 'Terbaru'
    expect(find.text('Terbaru'), findsOneWidget);
  });
}
