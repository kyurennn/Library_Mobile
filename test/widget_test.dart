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
}
