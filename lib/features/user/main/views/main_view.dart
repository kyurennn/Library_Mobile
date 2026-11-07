import 'package:flutter/material.dart';
import 'package:library_mobile/features/shared/catalog/views/catalog_view.dart';
import 'package:library_mobile/features/user/home/views/home_view.dart';
import 'package:library_mobile/features/user/main/widgets/user_bottom_nav.dart';
import 'package:library_mobile/features/user/profile/views/profile_view.dart';
import 'package:library_mobile/features/user/saved/views/saved_view.dart';

// Halaman utama dengan navigasi bottom bar
class MainView extends StatefulWidget {
  final int initialIndex;
  const MainView({super.key, this.initialIndex = 0});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _views = const [
    HomeView(),
    CatalogView(),
    SavedView(),
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
      body: IndexedStack(index: _currentIndex, children: _views),
      bottomNavigationBar: UserBottomNav(
        selectedIndex: _currentIndex,
        onSelected: _onDestinationSelected,
      ),
    );
  }
}