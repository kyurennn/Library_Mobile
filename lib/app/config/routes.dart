import 'package:flutter/material.dart';
import 'package:library_mobile/data/models/event_model.dart';
import 'package:library_mobile/data/models/sample_model.dart';
import 'package:library_mobile/features/auth/login_view.dart';
import 'package:library_mobile/features/shared/catalog/views/catalog_view.dart';
import 'package:library_mobile/features/shared/detail/views/detail_view.dart';
import 'package:library_mobile/features/user/events/views/event_detail_view.dart';
import 'package:library_mobile/features/user/events/views/events_view.dart';
import 'package:library_mobile/features/user/home/views/home_view.dart';
import 'package:library_mobile/features/user/main/views/main_view.dart';
import 'package:library_mobile/features/user/reservation/views/reservation_view.dart';
import 'package:library_mobile/features/user/saved/views/saved_view.dart';

// Definisi rute navigasi aplikasi
class AppRoutes {
  AppRoutes._();

  static const String main = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String catalog = '/catalog';
  static const String saved = '/saved';
  static const String detail = '/detail';
  static const String profile = '/profile';
  static const String reservation = '/reservation';
  static const String events = '/events';
  static const String eventDetail = '/event-detail';

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

      case saved:
        return MaterialPageRoute(
          builder: (_) => const SavedView(),
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
          builder: (_) => const MainView(initialIndex: 3),
          settings: settings,
        );

      case reservation:
        return MaterialPageRoute(
          builder: (_) => const ReservationView(),
          settings: settings,
        );

      case events:
        return MaterialPageRoute(
          builder: (_) => const EventsView(),
          settings: settings,
        );

      case eventDetail:
        final event = settings.arguments as EventItem?;
        return MaterialPageRoute(
          builder: (_) => EventDetailView(event: event),
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