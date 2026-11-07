import 'package:flutter/material.dart';

// Bottom navigation bar untuk role user (dipakai MainView dan halaman lain)
class UserBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const UserBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  static const Color _barBg = Color(0xFF090E1A);
  static const Color _cyan = Color(0xFF00A8E8);
  static const Color _grey = Color(0xFF64748B);
  static const Color _border = Color(0xFF1E2D4A);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _barBg,
        border: Border(top: BorderSide(color: _border, width: 0.8)),
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
            return IconThemeData(color: selected ? _cyan : _grey, size: 24);
          }),
        ),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onSelected,
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
              icon: Icon(Icons.bookmark_border_rounded),
              selectedIcon: Icon(Icons.bookmark_rounded),
              label: 'Tersimpan',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline_rounded),
              selectedIcon: Icon(Icons.person_rounded),
              label: 'Akun',
            ),
          ],
        ),
      ),
    );
  }
}