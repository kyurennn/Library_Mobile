import 'package:flutter/material.dart';
import 'package:library_mobile/data/models/map_model.dart';

// Foto profil teman berbentuk lingkaran (fallback: inisial nama)
class FriendAvatar extends StatelessWidget {
  final MapFriend friend;
  final double size;
  final double borderWidth;
  final bool showOnline;

  const FriendAvatar({
    super.key,
    required this.friend,
    this.size = 52,
    this.borderWidth = 2,
    this.showOnline = false,
  });

  static const Color _cyan = Color(0xFF00A8E8);
  static const Color _green = Color(0xFF10B981);
  static const List<Color> _fallbackColors = [
    Color(0xFF0EA5E9),
    Color(0xFFEC4899),
    Color(0xFF8B5CF6),
    Color(0xFFF59E0B),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size,
            height: size,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _cyan, width: borderWidth),
            ),
            child: ClipOval(child: _buildImage()),
          ),
          if (showOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: size * 0.26,
                height: size * 0.26,
                decoration: BoxDecoration(
                  color: _green,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF0B132B), width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    final asset = friend.avatarAsset;
    if (asset == null) return _buildFallback();

    return Image.asset(
      asset,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => _buildFallback(),
    );
  }

  Widget _buildFallback() {
    final initial = friend.name.isEmpty ? '?' : friend.name[0].toUpperCase();
    final color = _fallbackColors[
        friend.name.isEmpty ? 0 : friend.name.codeUnitAt(0) % _fallbackColors.length];

    return Container(
      color: color,
      alignment: Alignment.center,
      child: Text(
        initial,
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.38,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}