import 'package:flutter/material.dart';

// Helper tanggal berbahasa Indonesia untuk halaman reservasi
class ReservationDates {
  ReservationDates._();

  static const List<String> _shortDays = [
    'SEN',
    'SEL',
    'RAB',
    'KAM',
    'JUM',
    'SAB',
    'MIN',
  ];
  static const List<String> _fullDays = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];
  static const List<String> _shortMonths = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];
  static const List<String> _fullMonths = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  static String shortDay(DateTime d) => _shortDays[d.weekday - 1];
  static String fullDay(DateTime d) => _fullDays[d.weekday - 1];

  // Contoh: "Okt 2024"
  static String monthYear(DateTime d) => '${_shortMonths[d.month - 1]} ${d.year}';

  // Contoh: "Kamis, 24 Oktober 2024"
  static String fullDate(DateTime d) =>
      '${fullDay(d)}, ${d.day} ${_fullMonths[d.month - 1]} ${d.year}';

  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  // Daftar [count] hari mulai dari hari ini
  static List<DateTime> upcoming({int count = 5}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return List.generate(count, (i) => today.add(Duration(days: i)));
  }
}

// Baris pilihan tanggal (5 hari ke depan)
class DateStrip extends StatelessWidget {
  final List<DateTime> days;
  final DateTime selected;
  final ValueChanged<DateTime> onChanged;

  const DateStrip({
    super.key,
    required this.days,
    required this.selected,
    required this.onChanged,
  });

  static const Color _cardBg = Color(0xFF131D33);
  static const Color _textGrey = Color(0xFF8E9BAE);

  String _subLabel(int index, DateTime d) {
    if (index == 0) return 'Hari Ini';
    if (index == 1) return 'Besok';
    return ReservationDates.fullDay(d);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < days.length; i++)
          Expanded(child: _buildItem(i, days[i])),
      ],
    );
  }

  Widget _buildItem(int index, DateTime day) {
    final isSelected = ReservationDates.isSameDay(day, selected);

    return InkWell(
      onTap: () => onChanged(day),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? _cardBg : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              ReservationDates.shortDay(day),
              style: TextStyle(
                color: isSelected ? Colors.white : _textGrey,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${day.day}',
              style: TextStyle(
                color: isSelected ? Colors.white : _textGrey,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              _subLabel(index, day),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF64748B),
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}