import 'package:flutter/material.dart';
import 'package:library_mobile/features/catalog/views/catalog_view.dart';
import 'package:library_mobile/features/home/views/home_view.dart';
import 'package:library_mobile/features/profile/views/profile_view.dart';

// Halaman utama dengan navigasi bottom bar
class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  // Warna navigasi bottom bar
  static const Color _barBg = Color(0xFF090E1A);
  static const Color _cyan = Color(0xFF00A8E8);
  static const Color _grey = Color(0xFF64748B);
  static const Color _border = Color(0xFF1E2D4A);

  // Daftar tab tampilan utama
  final List<Widget> _views = const [
    HomeView(),
    CatalogView(),
    ProfileView(),
  ];

  void _onDestinationSelected(int index) {
    if (_currentIndex != index) {
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B132B),
      body: IndexedStack(
        index: _currentIndex,
        children: _views,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: _barBg,
          border: Border(
            top: BorderSide(color: _border, width: 0.8),
          ),
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: _barBg,
            surfaceTintColor: Colors.transparent,
            indicatorColor: _cyan.withValues(alpha: 0.15),
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
              final selected = states.contains(WidgetState.selected);
              return TextStyle(
                color: selected ? _cyan : _grey,
                fontSize: 11,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
              );
            }),
            iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
              final selected = states.contains(WidgetState.selected);
              return IconThemeData(
                color: selected ? _cyan : _grey,
                size: 24,
              );
            }),
          ),
          child: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: _onDestinationSelected,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: 'Beranda',
              ),
              NavigationDestination(
                icon: Icon(Icons.menu_book_outlined),
                selectedIcon: Icon(Icons.menu_book_rounded),
                label: 'Jelajahi',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline_rounded),
                selectedIcon: Icon(Icons.person_rounded),
                label: 'Akun',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
