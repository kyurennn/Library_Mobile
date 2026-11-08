import 'package:flutter/material.dart';
import 'package:library_mobile/core/utils/formatters.dart';
import 'package:library_mobile/data/dummy/borrowing_dummy.dart';
import 'package:library_mobile/data/models/borrowing_model.dart';
import 'package:library_mobile/features/shared/detail/views/detail_view.dart';

// Halaman Daftar Peminjaman
class BorrowingListPage extends StatefulWidget {
  const BorrowingListPage({super.key});

  @override
  State<BorrowingListPage> createState() => _BorrowingListPageState();
}

class _BorrowingListPageState extends State<BorrowingListPage> {
  // Skema warna konsisten dengan ProfilePage
  static const Color _bg = Color(0xFF0F172A);
  static const Color _cardBg = Color(0xFF1E293B);
  static const Color _border = Color(0xFF334155);
  static const Color _blue = Color(0xFF3B82F6);
  static const Color _green = Color(0xFF10B981);
  static const Color _red = Color(0xFFF87171);
  static const Color _amber = Color(0xFFF59E0B);
  static const Color _textGrey = Color(0xFF94A3B8);

  static const List<String> _tabs = ['Semua', 'Aktif', 'Terlambat', 'Riwayat'];
  int _selectedTab = 0;

  // Data bersama dengan ProfilePage & FinePage
  final List<BorrowingItem> _items = BorrowingDummy.items;

  List<BorrowingItem> get _filtered {
    switch (_selectedTab) {
      case 1:
        return _items.where((e) => e.status == BorrowStatus.active).toList();
      case 2:
        return _items.where((e) => e.status == BorrowStatus.overdue).toList();
      case 3:
        return _items.where((e) => e.status == BorrowStatus.returned).toList();
      default:
        // Urutkan: terlambat → aktif → riwayat
        final list = [..._items];
        list.sort((a, b) => a.status == b.status
            ? a.dueDate.compareTo(b.dueDate)
            : _statusOrder(a.status).compareTo(_statusOrder(b.status)));
        return list;
    }
  }

  int _statusOrder(BorrowStatus s) => switch (s) {
        BorrowStatus.overdue => 0,
        BorrowStatus.active => 1,
        BorrowStatus.returned => 2,
      };

  int _count(BorrowStatus s) => _items.where((e) => e.status == s).length;

  // Denda berjalan dari buku yang masih terlambat
  int get _totalFine => _items
      .where((e) => e.fineStatus == FineStatus.running)
      .fold(0, (sum, e) => sum + e.fine);

  @override
  Widget build(BuildContext context) {
    final items = _filtered;

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        title: const Text(
          'Daftar Peminjaman',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: _cardBg,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSummary(),
          if (_totalFine > 0) ...[
            const SizedBox(height: 12),
            _buildFineBanner(),
          ],
          const SizedBox(height: 20),
          _buildTabs(),
          const SizedBox(height: 16),
          if (items.isEmpty)
            _buildEmpty()
          else
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildBorrowCard(item),
              ),
            ),
          const SizedBox(height: 8),
          _buildRulesInfo(),
        ],
      ),
    );
  }

  // Ringkasan jumlah peminjaman
  Widget _buildSummary() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.menu_book_rounded,
            value: '${_count(BorrowStatus.active)}',
            label: 'Aktif',
            color: _blue,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStatCard(
            icon: Icons.warning_amber_rounded,
            value: '${_count(BorrowStatus.overdue)}',
            label: 'Terlambat',
            color: _red,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStatCard(
            icon: Icons.task_alt_rounded,
            value: '${_count(BorrowStatus.returned)}',
            label: 'Dikembalikan',
            color: _green,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: _textGrey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Banner peringatan denda
  Widget _buildFineBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _red.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: _red, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: const TextStyle(color: Colors.white, fontSize: 12.5),
                children: [
                  const TextSpan(text: 'Ada buku yang terlambat. Denda berjalan: '),
                  TextSpan(
                    text: AppFormatters.formatCurrency(_totalFine),
                    style: const TextStyle(
                      color: _red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tab filter status
  Widget _buildTabs() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _tabs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final selected = i == _selectedTab;
          return GestureDetector(
            onTap: () => setState(() => _selectedTab = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? _blue : _cardBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: selected ? _blue : _border),
              ),
              child: Text(
                _tabs[i],
                style: TextStyle(
                  color: selected ? Colors.white : _textGrey,
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Kartu satu peminjaman
  Widget _buildBorrowCard(BorrowingItem item) {
    final statusColor = _statusColor(item.status);

    return Material(
      color: _cardBg,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showDetailSheet(item),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: item.status == BorrowStatus.overdue
                  ? _red.withValues(alpha: 0.5)
                  : _border,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCover(item, width: 56, height: 80),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                item.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.5,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            _buildStatusChip(item.status),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.author,
                          style: const TextStyle(color: _textGrey, fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined,
                                color: _textGrey, size: 13),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                item.location,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: _textGrey, fontSize: 11.5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildDateRow(item),
              if (item.status != BorrowStatus.returned) ...[
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: item.progress,
                    minHeight: 5,
                    backgroundColor: _border,
                    valueColor: AlwaysStoppedAnimation(
                      item.status == BorrowStatus.overdue
                          ? _red
                          : item.daysLeft <= 3
                              ? _amber
                              : _blue,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _remainingText(item),
                        style: TextStyle(
                          color: item.status == BorrowStatus.overdue
                              ? _red
                              : item.daysLeft <= 3
                                  ? _amber
                                  : _textGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (item.canExtend)
                      SizedBox(
                        height: 30,
                        child: TextButton.icon(
                          onPressed: () => _confirmExtend(item),
                          style: TextButton.styleFrom(
                            foregroundColor: _blue,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            backgroundColor: _blue.withValues(alpha: 0.12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(Icons.update, size: 15),
                          label: const Text(
                            'Perpanjang',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                ),
              ] else
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Dikembalikan ${AppFormatters.formatDate(item.returnDate!)}',
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateRow(BorrowingItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildDateInfo(
              'Tanggal Pinjam',
              AppFormatters.formatDate(item.borrowDate),
            ),
          ),
          Container(width: 1, height: 28, color: _border),
          const SizedBox(width: 12),
          Expanded(
            child: _buildDateInfo(
              'Batas Kembali',
              AppFormatters.formatDate(item.dueDate),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: _textGrey, fontSize: 10.5)),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildCover(BorrowingItem item,
      {required double width, required double height}) {
    final placeholder = Container(
      width: width,
      height: height,
      color: _border,
      child: const Icon(Icons.menu_book_rounded, color: _textGrey, size: 24),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: item.coverAsset == null
          ? placeholder
          : Image.asset(
              item.coverAsset!,
              width: width,
              height: height,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => placeholder,
            ),
    );
  }

  Widget _buildStatusChip(BorrowStatus status) {
    final color = _statusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _statusLabel(status),
        style: TextStyle(
          color: color,
          fontSize: 10.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Icon(Icons.inbox_outlined, color: _textGrey.withValues(alpha: 0.6), size: 56),
          const SizedBox(height: 12),
          const Text(
            'Tidak ada peminjaman',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Belum ada buku pada kategori ini.',
            style: TextStyle(color: _textGrey, fontSize: 12.5),
          ),
        ],
      ),
    );
  }

  // Info aturan peminjaman di bagian bawah
  Widget _buildRulesInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _blue.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _blue.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: _blue, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Masa pinjam 14 hari dan dapat diperpanjang '
              '${BorrowingItem.maxExtend}x selama ${BorrowingItem.extendDays} hari. '
              'Keterlambatan dikenakan denda '
              '${AppFormatters.formatCurrency(BorrowingItem.finePerDay)}/hari per buku.',
              style: const TextStyle(color: _textGrey, fontSize: 12, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  // Bottom sheet detail peminjaman
  void _showDetailSheet(BorrowingItem item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: _cardBg,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: _border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCover(item, width: 70, height: 100),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStatusChip(item.status),
                          const SizedBox(height: 8),
                          Text(
                            item.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(item.author,
                              style: const TextStyle(
                                  color: _textGrey, fontSize: 12.5)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                _sheetRow('ID Peminjaman', 'PJM-${item.id.toString().padLeft(5, '0')}'),
                _sheetRow('Kategori', item.category),
                _sheetRow('Lokasi', item.location),
                _sheetRow('Tanggal Pinjam', AppFormatters.formatDate(item.borrowDate)),
                _sheetRow('Batas Kembali', AppFormatters.formatDate(item.dueDate)),
                if (item.returnDate != null)
                  _sheetRow('Tanggal Kembali',
                      AppFormatters.formatDate(item.returnDate!)),
                _sheetRow('Perpanjangan',
                    '${item.extendCount}/${BorrowingItem.maxExtend} kali'),
                if (item.fine > 0)
                  _sheetRow(
                    'Denda',
                    item.fineStatus == FineStatus.paid
                        ? '${AppFormatters.formatCurrency(item.fine)} (Lunas)'
                        : AppFormatters.formatCurrency(item.fine),
                    valueColor:
                        item.fineStatus == FineStatus.paid ? _green : _red,
                  ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DetailView(book: item.toSampleModel()),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(46),
                          side: const BorderSide(color: _border),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Lihat Buku'),
                      ),
                    ),
                    if (item.canExtend) ...[
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(sheetContext);
                            _confirmExtend(item);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _blue,
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(46),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Perpanjang'),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _sheetRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
                style: const TextStyle(color: _textGrey, fontSize: 13)),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Dialog konfirmasi perpanjangan
  void _confirmExtend(BorrowingItem item) {
    final newDue = item.dueDate.add(const Duration(days: BorrowingItem.extendDays));

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: _cardBg,
        title: const Text('Perpanjang Peminjaman',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        content: Text(
          'Perpanjang "${item.title}" selama ${BorrowingItem.extendDays} hari?\n\n'
          'Batas kembali baru: ${AppFormatters.formatDate(newDue)}',
          style: const TextStyle(color: _textGrey, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal', style: TextStyle(color: _textGrey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              setState(() {
                item.dueDate = newDue;
                item.extendCount++;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Berhasil diperpanjang hingga ${AppFormatters.formatDate(newDue)}'),
                  backgroundColor: _green,
                ),
              );
            },
            child: const Text('Perpanjang',
                style: TextStyle(color: _blue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  String _remainingText(BorrowingItem item) {
    if (item.status == BorrowStatus.overdue) {
      return 'Terlambat ${-item.daysLeft} hari · Denda ${AppFormatters.formatCurrency(item.fine)}';
    }
    if (item.daysLeft == 0) return 'Jatuh tempo hari ini';
    return 'Sisa ${item.daysLeft} hari';
  }

  Color _statusColor(BorrowStatus s) => switch (s) {
        BorrowStatus.active => _blue,
        BorrowStatus.overdue => _red,
        BorrowStatus.returned => _green,
      };

  String _statusLabel(BorrowStatus s) => switch (s) {
        BorrowStatus.active => 'Aktif',
        BorrowStatus.overdue => 'Terlambat',
        BorrowStatus.returned => 'Dikembalikan',
      };
}
