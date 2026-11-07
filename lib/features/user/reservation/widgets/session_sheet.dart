import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:library_mobile/data/models/room_model.dart';
import 'package:library_mobile/features/user/reservation/widgets/date_strip.dart';

// Tampilkan sheet pilih sesi dengan latar blur.
// Sheet tertutup saat menekan area gelap di luar sheet, Batal, X, atau Konfirmasi.
Future<void> showSessionSheet(
  BuildContext context, {
  required Room room,
  required DateTime date,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'Tutup',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (_, _, _, child) => child,
    pageBuilder: (ctx, animation, _) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );

      return Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            // Latar gelap + blur, tekan untuk menutup
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(ctx).pop(),
                child: AnimatedBuilder(
                  animation: curved,
                  builder: (_, _) => ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 6 * curved.value,
                        sigmaY: 6 * curved.value,
                      ),
                      child: Container(
                        color: Colors.black.withValues(
                          alpha: 0.55 * curved.value,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(curved),
                child: SessionSheet(room: room, date: date),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class SessionSheet extends StatefulWidget {
  final Room room;
  final DateTime date;

  const SessionSheet({super.key, required this.room, required this.date});

  @override
  State<SessionSheet> createState() => _SessionSheetState();
}

class _SessionSheetState extends State<SessionSheet> {
  static const Color _sheetBg = Color(0xFF0D1426);
  static const Color _cardBorder = Color(0xFF1E2D4A);
  static const Color _green = Color(0xFF34D399);
  static const Color _textGrey = Color(0xFF8E9BAE);
  static const Color _subGrey = Color(0xFF64748B);

  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.room.preselectedIndex;
  }

  bool get _isToday =>
      ReservationDates.isSameDay(widget.date, DateTime.now());

  void _close() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.92;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: maxHeight),
      decoration: const BoxDecoration(
        color: _sheetBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(top: BorderSide(color: _cardBorder, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: _cardBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 18),
                    _buildDateCard(),
                    const SizedBox(height: 18),
                    _buildListHeader(),
                    const SizedBox(height: 10),
                    for (int i = 0; i < widget.room.sessions.length; i++) ...[
                      _buildSessionTile(i, widget.room.sessions[i]),
                      const SizedBox(height: 10),
                    ],
                    const SizedBox(height: 2),
                    _buildInfoChips(),
                  ],
                ),
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.access_time, color: Colors.white, size: 14),
                  SizedBox(width: 6),
                  Text(
                    'PILIH SESI WAKTU',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                widget.room.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: _textGrey,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.room.location,
                    style: const TextStyle(color: _textGrey, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: _close,
          icon: const Icon(Icons.close, color: _textGrey, size: 22),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          tooltip: 'Tutup',
        ),
      ],
    );
  }

  Widget _buildDateCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _cardBorder),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today_outlined, color: _textGrey, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              ReservationDates.fullDate(widget.date),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (_isToday)
            const Text(
              'Hari Ini',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildListHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Daftar Sesi Tersedia',
          style: TextStyle(color: _textGrey, fontSize: 12.5),
        ),
        Text(
          'Durasi: ${widget.room.sessionHours} Jam / Sesi',
          style: const TextStyle(color: _textGrey, fontSize: 12.5),
        ),
      ],
    );
  }

  Widget _buildSessionTile(int index, RoomSession session) {
    final isBooked = !session.isAvailable;
    final isSelected = _selectedIndex == index;

    final Color borderColor = isSelected ? Colors.white : _cardBorder;
    final Color dotColor = isBooked
        ? _subGrey
        : (isSelected ? Colors.white : _green);

    final String statusText = isBooked
        ? 'Sudah Direservasi'
        : (isSelected ? 'Terpilih' : 'Tersedia');

    final Widget trailing;
    if (isBooked) {
      trailing = const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lock_outline, color: _subGrey, size: 14),
          SizedBox(width: 4),
          Text('Penuh', style: TextStyle(color: _subGrey, fontSize: 12.5)),
        ],
      );
    } else if (isSelected) {
      trailing = const Icon(Icons.check, color: Colors.white, size: 20);
    } else {
      trailing = const Text(
        'Pilih',
        style: TextStyle(
          color: _green,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    return Opacity(
      opacity: isBooked ? 0.6 : 1,
      child: InkWell(
        onTap: isBooked ? null : () => setState(() => _selectedIndex = index),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: isSelected ? 1.5 : 1),
          ),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.timeRange,
                      style: TextStyle(
                        color: isBooked ? _subGrey : Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        decoration: isBooked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationColor: _subGrey,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${session.label} · $statusText',
                      style: TextStyle(
                        color: isSelected ? Colors.white : _textGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChips() {
    Widget chip(IconData icon, String text) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _cardBorder),
          ),
          child: Row(
            children: [
              Icon(icon, color: _textGrey, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFFCBD5E1),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Row(
      children: [
        chip(
          Icons.group_outlined,
          'Kapasitas: ${widget.room.capacityText}',
        ),
        const SizedBox(width: 10),
        chip(
          Icons.timer_outlined,
          'Maks. Kuota: ${widget.room.maxQuotaHours} Jam',
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextButton(
              onPressed: _close,
              child: const Text(
                'Batal',
                style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 14),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextButton(
              onPressed: _close,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Konfirmasi Sesi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}