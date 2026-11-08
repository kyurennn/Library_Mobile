import 'package:flutter/material.dart';
import 'package:library_mobile/data/models/map_model.dart';
import 'package:library_mobile/features/user/map/widgets/friend_avatar.dart';

// Tampilan peta kampus (ilustrasi dummy) beserta lokasi pengguna dan teman
class CampusMap extends StatefulWidget {
  final List<MapFriend> friends;

  const CampusMap({super.key, required this.friends});

  @override
  State<CampusMap> createState() => _CampusMapState();
}

class _CampusMapState extends State<CampusMap>
    with SingleTickerProviderStateMixin {
  static const Color _cyan = Color(0xFF00A8E8);
  static const Color _chipBg = Color(0xE60B132B);
  static const Color _border = Color(0xFF1E2D4A);
  static const double _height = 320;

  // Posisi dummy sebagai pecahan lebar (dx) dan tinggi (dy) peta
  static const Offset _userSpot = Offset(0.42, 0.66);
  static const List<Offset> _friendSpots = [
    Offset(0.40, 0.30),
    Offset(0.66, 0.16),
    Offset(0.88, 0.36),
  ];

  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _border),
      ),
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;

          return Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(painter: _MapPainter(user: _userSpot)),
              ),
              _zoneLabel('Zona Belajar', w * 0.30, h * 0.47),
              _zoneLabel('Rak Buku', w * 0.74, h * 0.50),
              _zoneLabel('Lobi Utama', w * 0.86, h * 0.72),
              ..._buildFriendPins(w, h),
              _buildUserMarker(w, h),
              // Kompas dan label 3D
              Positioned(top: 12, right: 12, child: _roundIcon(Icons.explore_outlined)),
              Positioned(top: 54, right: 12, child: _chip3d()),
              // Kontrol zoom
              Positioned(bottom: 12, right: 12, child: _zoomControl()),
              // Status Ultra-Wideband
              Positioned(bottom: 12, left: 12, child: _uwbChip()),
            ],
          );
        },
      ),
    );
  }

  Widget _zoneLabel(String text, double x, double y) {
    return Positioned(
      left: x - 45,
      top: y,
      width: 90,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.55),
          fontSize: 9.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  List<Widget> _buildFriendPins(double w, double h) {
    final count = widget.friends.length < _friendSpots.length
        ? widget.friends.length
        : _friendSpots.length;

    return [
      for (int i = 0; i < count; i++)
        Positioned(
          left: w * _friendSpots[i].dx - 40,
          top: h * _friendSpots[i].dy - 20,
          width: 80,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FriendAvatar(
                friend: widget.friends[i],
                size: 36,
                borderWidth: 1.5,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _chipBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.friends[i].name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
    ];
  }

  Widget _buildUserMarker(double w, double h) {
    return Positioned(
      left: w * _userSpot.dx - 45,
      top: h * _userSpot.dy - 45,
      width: 90,
      height: 90,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _pulse,
            builder: (_, _) {
              final t = _pulse.value;
              return Container(
                width: 28 + 62 * t,
                height: 28 + 62 * t,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _cyan.withValues(alpha: 0.28 * (1 - t)),
                ),
              );
            },
          ),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  _cyan.withValues(alpha: 0.45),
                  _cyan.withValues(alpha: 0),
                ],
              ),
            ),
          ),
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: _cyan,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: _cyan.withValues(alpha: 0.8),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
          Positioned(
            top: -22,
            left: -30,
            right: -30,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _chipBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _cyan.withValues(alpha: 0.45)),
                ),
                child: const Text(
                  'Lokasi Anda',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _roundIcon(IconData icon) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: _chipBg,
        shape: BoxShape.circle,
        border: Border.all(color: _border),
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }

  Widget _chip3d() {
    return Container(
      width: 34,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: _chipBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _border),
      ),
      child: const Text(
        '3D',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 11.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _zoomControl() {
    return Container(
      width: 34,
      decoration: BoxDecoration(
        color: _chipBg,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: _border),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 34,
            child: Icon(Icons.add, color: Colors.white, size: 18),
          ),
          SizedBox(
            height: 34,
            child: Icon(Icons.remove, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _uwbChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _chipBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.wifi_tethering, color: _cyan, size: 15),
          SizedBox(width: 6),
          Text(
            'Ultra-Wideband Aktif',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// Ilustrasi peta isometrik sederhana: grid, jalan, gedung, dan rute
class _MapPainter extends CustomPainter {
  final Offset user;

  const _MapPainter({required this.user});

  // (pecahan x, pecahan y, lebar, tinggi) diurutkan dari belakang ke depan
  static const List<(double, double, double, double)> _buildings = [
    (0.30, 0.16, 90, 26),
    (0.64, 0.12, 80, 20),
    (0.10, 0.30, 70, 16),
    (0.86, 0.26, 70, 14),
    (0.20, 0.52, 80, 18),
    (0.78, 0.58, 90, 22),
    (0.10, 0.86, 70, 12),
    (0.55, 0.88, 100, 14),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final rect = Offset.zero & size;

    // Latar
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF111B2E), Color(0xFF0A1220)],
        ).createShader(rect),
    );

    // Garis grid isometrik
    final grid = Paint()
      ..color = const Color(0xFF1B2940).withValues(alpha: 0.6)
      ..strokeWidth = 0.8;
    for (double y = -w * 0.5; y < h + 40; y += 44) {
      canvas.drawLine(Offset(0, y), Offset(w, y + w * 0.5), grid);
    }
    for (double y = 0; y < h + w * 0.5; y += 44) {
      canvas.drawLine(Offset(0, y), Offset(w, y - w * 0.5), grid);
    }

    // Jalan
    final road = Paint()
      ..color = const Color(0xFF0C1526)
      ..strokeWidth = 22
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(0, h * 0.74), Offset(w, h * 0.74 - w * 0.5), road);
    canvas.drawLine(Offset(0, h * 0.10), Offset(w, h * 0.10 + w * 0.5), road);

    // Gedung
    for (final b in _buildings) {
      _drawBox(canvas, Offset(w * b.$1, h * b.$2), b.$3, b.$4);
    }

    // Rute putus-putus dari lokasi pengguna
    final from = Offset(w * user.dx, h * user.dy);
    final to = Offset(w * 0.80, h * 0.84);
    final routePaint = Paint()
      ..color = const Color(0xFF00A8E8).withValues(alpha: 0.65)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(from.dx, from.dy)
      ..lineTo(to.dx, to.dy);
    for (final metric in path.computeMetrics()) {
      double d = 0;
      while (d < metric.length) {
        canvas.drawPath(metric.extractPath(d, d + 6), routePaint);
        d += 11;
      }
    }
  }

  void _drawBox(Canvas canvas, Offset base, double width, double height) {
    final a = width / 2;
    final b = a / 2;
    final cx = base.dx;
    final cy = base.dy;

    final top = Path()
      ..moveTo(cx, cy - height - b)
      ..lineTo(cx + a, cy - height)
      ..lineTo(cx, cy - height + b)
      ..lineTo(cx - a, cy - height)
      ..close();
    final left = Path()
      ..moveTo(cx - a, cy - height)
      ..lineTo(cx, cy - height + b)
      ..lineTo(cx, cy + b)
      ..lineTo(cx - a, cy)
      ..close();
    final right = Path()
      ..moveTo(cx, cy - height + b)
      ..lineTo(cx + a, cy - height)
      ..lineTo(cx + a, cy)
      ..lineTo(cx, cy + b)
      ..close();

    final outline = Paint()
      ..color = const Color(0xFF26354F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    canvas.drawPath(left, Paint()..color = const Color(0xFF141F34));
    canvas.drawPath(right, Paint()..color = const Color(0xFF0F1829));
    canvas.drawPath(top, Paint()..color = const Color(0xFF1C2842));
    canvas.drawPath(left, outline);
    canvas.drawPath(right, outline);
    canvas.drawPath(top, outline);
  }

  @override
  bool shouldRepaint(covariant _MapPainter oldDelegate) =>
      oldDelegate.user != user;
}