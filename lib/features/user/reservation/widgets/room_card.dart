import 'package:flutter/material.dart';
import 'package:library_mobile/data/models/room_model.dart';

// Kartu ruangan: foto, lokasi, fasilitas, ringkasan sesi, dan tombol pilih sesi
class RoomCard extends StatelessWidget {
  final Room room;
  final VoidCallback onPressed;

  const RoomCard({super.key, required this.room, required this.onPressed});

  static const Color _cardBg = Color(0xFF131D33);
  static const Color _cardBorder = Color(0xFF1E2D4A);
  static const Color _green = Color(0xFF10B981);
  static const Color _textGrey = Color(0xFF8E9BAE);
  static const Color _subGrey = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: _textGrey,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      room.location,
                      style: const TextStyle(color: _textGrey, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  room.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: room.facilities.map(_buildFacilityChip).toList(),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pilih Sesi:',
                  style: TextStyle(color: _textGrey, fontSize: 12),
                ),
                const SizedBox(height: 10),
                _buildSessionSummary(),
              ],
            ),
          ),
          const Divider(color: _cardBorder, height: 1),
          InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    room.preselectedIndex != null
                        ? 'Pesan Ruangan'
                        : 'Pilih Sesi',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            room.imageAsset,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              color: const Color(0xFF1E2D4A),
              child: const Icon(
                Icons.meeting_room_outlined,
                color: _textGrey,
                size: 36,
              ),
            ),
          ),
          Positioned(top: 10, left: 10, child: _buildBadge()),
        ],
      ),
    );
  }

  // Badge ketersediaan di pojok foto
  Widget _buildBadge() {
    final available = room.availableCount;
    final Widget content;

    if (available == 0) {
      content = const Text(
        'Penuh',
        style: TextStyle(
          color: Color(0xFFF87171),
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
        ),
      );
    } else if (available <= 2) {
      content = Text(
        '$available Slot Tersisa',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
        ),
      );
    } else {
      content = const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, color: _green, size: 7),
          SizedBox(width: 6),
          Text(
            'Tersedia',
            style: TextStyle(
              color: _green,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: content,
    );
  }

  Widget _buildFacilityChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1729),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 11.5),
      ),
    );
  }

  // Ringkasan maksimal 3 sesi pertama
  Widget _buildSessionSummary() {
    final shown = room.sessions.take(3).toList();

    return Row(
      children: [
        for (int i = 0; i < shown.length; i++)
          Expanded(
            child: _buildSummaryItem(shown[i], i == room.preselectedIndex),
          ),
      ],
    );
  }

  Widget _buildSummaryItem(RoomSession session, bool isSelected) {
    if (!session.isAvailable) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              session.timeRange,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: _subGrey,
                fontSize: 12,
                decoration: TextDecoration.lineThrough,
                decorationColor: _subGrey,
              ),
            ),
          ),
          const SizedBox(width: 3),
          const Icon(Icons.lock_outline, color: _subGrey, size: 12),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            session.timeRange,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFFCBD5E1),
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
            ),
          ),
        ),
        if (isSelected) ...[
          const SizedBox(width: 3),
          const Icon(Icons.check, color: Colors.white, size: 13),
        ],
      ],
    );
  }
}