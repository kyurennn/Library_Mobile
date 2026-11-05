import 'package:flutter/material.dart';
import 'package:library_mobile/app/config/constants.dart';
import 'package:library_mobile/app/config/routes.dart';
import 'package:library_mobile/app/config/theme.dart';
import 'package:library_mobile/features/main/views/main_view.dart';

// Konfigurasi utama aplikasi: judul, tema, dan rute navigasi
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const MainView(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
