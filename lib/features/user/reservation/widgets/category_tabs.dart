import 'package:flutter/material.dart';

// Tab kategori ruangan yang bisa digeser horizontal
class CategoryTabs extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final ValueChanged<String> onChanged;

  const CategoryTabs({
    super.key,
    required this.categories,
    required this.selected,
    required this.onChanged,
  });

  static const Color _cyan = Color(0xFF00A8E8);
  static const Color _textGrey = Color(0xFF8E9BAE);
  static const Color _border = Color(0xFF1E2D4A);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _border, width: 1)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: categories.map((c) {
            final isSelected = c == selected;
            return InkWell(
              onTap: () => onChanged(c),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? _cyan : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  c,
                  style: TextStyle(
                    color: isSelected ? Colors.white : _textGrey,
                    fontSize: 13.5,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}