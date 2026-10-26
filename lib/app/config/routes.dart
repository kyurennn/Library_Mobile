import 'package:flutter/material.dart';
import 'package:library_mobile/data/models/sample_model.dart';
import 'package:library_mobile/features/auth/views/login_view.dart';
import 'package:library_mobile/features/catalog/views/catalog_view.dart';
import 'package:library_mobile/features/detail/views/detail_view.dart';
import 'package:library_mobile/features/home/views/home_view.dart';
import 'package:library_mobile/features/main/views/main_view.dart';
import 'package:library_mobile/features/profile/views/profile_view.dart';

// Definisi rute navigasi aplikasi
class AppRoutes {
  AppRoutes._();

  static const String main = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String catalog = '/catalog';
  static const String detail = '/detail';
  static const String profile = '/profile';

  // Handler rute bernama
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return MaterialPageRoute(
          builder: (_) => const MainView(),
          settings: settings,
        );

      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
          settings: settings,
        );

      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
          settings: settings,
        );

      case catalog:
        return MaterialPageRoute(
          builder: (_) => const CatalogView(),
          settings: settings,
        );

      case detail:
        final book = settings.arguments as SampleModel?;
        return MaterialPageRoute(
          builder: (_) => DetailView(book: book),
          settings: settings,
        );

      case profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileView(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Halaman Tidak Ditemukan')),
            body: Center(
              child: Text('Rute ${settings.name} tidak terdaftar.'),
            ),
          ),
        );
    }
  }
}
