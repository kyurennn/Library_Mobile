import 'package:flutter/material.dart';
import 'package:library_mobile/core/utils/formatters.dart';
import 'package:library_mobile/data/dummy/borrowing_dummy.dart';
import 'package:library_mobile/data/models/borrowing_model.dart';
import 'package:library_mobile/features/user/profile/views/borrowing_list_page.dart';

// Halaman Denda: tagihan keterlambatan & riwayat pembayaran
class FinePage extends StatefulWidget {
  const FinePage({super.key});

  @override
  State<FinePage> createState() => _FinePageState();
}

class _FinePageState extends State<FinePage> {
  // Skema warna konsisten dengan ProfilePage & BorrowingListPage
  static const Color _bg = Color(0xFF0F172A);
  static const Color _cardBg = Color(0xFF1E293B);
  static const Color _border = Color(0xFF334155);
  static const Color _blue = Color(0xFF3B82F6);
  static const Color _green = Color(0xFF10B981);
  static const Color _red = Color(0xFFF87171);
  static const Color _amber = Color(0xFFF59E0B);
  static const Color _textGrey = Color(0xFF94A3B8);

  static const List<String> _tabs = ['Belum Lunas', 'Riwayat'];
  static const List<_PaymentMethod> _methods = [
    _PaymentMethod('QRIS', 'Scan dengan e-wallet / m-banking', Icons.qr_code_2),
    _PaymentMethod('Virtual Account', 'Transfer via bank', Icons.account_balance),
    _PaymentMethod('Bayar di Loket', 'Tunai di meja sirkulasi', Icons.storefront_outlined),
  ];

  int _selectedTab = 0;

  // Data bersama dengan ProfilePage & BorrowingListPage
  List<BorrowingItem> get _items => BorrowingDummy.items;

  List<BorrowingItem> get _running =>
      _items.where((e) => e.fineStatus == FineStatus.running).toList();

  List<BorrowingItem> get _unpaid =>
      _items.where((e) => e.fineStatus == FineStatus.unpaid).toList();

  List<BorrowingItem> get _paid => _items
      .where((e) => e.fineStatus == FineStatus.paid)
      .toList()
    ..sort((a, b) => b.finePaidDate!.compareTo(a.finePaidDate!));

  int _sum(List<BorrowingItem> list) => list.fold(0, (s, e) => s + e.fine);

  @override
  Widget build(BuildContext context) {
    final running = _running;
    final unpaid = _unpaid;
    final paid = _paid;

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        title: const Text(
          'Denda',
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
          _buildSummaryCard(running, unpaid, paid),
          const SizedBox(height: 20),
          _buildTabs(),
          const SizedBox(height: 16),
          if (_selectedTab == 0) ..._buildOutstandingTab(running, unpaid)
          else ..._buildHistoryTab(paid),
          const SizedBox(height: 8),
          _buildRulesInfo(),
        ],
      ),
      bottomNavigationBar:
          unpaid.isNotEmpty && _selectedTab == 0 ? _buildPayBar(unpaid) : null,
    );
  }

  // ---------- Ringkasan ----------

  Widget _buildSummaryCard(
    List<BorrowingItem> running,
    List<BorrowingItem> unpaid,
    List<BorrowingItem> paid,
  ) {
    final outstanding = _sum(running) + _sum(unpaid);
    final isClear = outstanding == 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isClear ? _green.withValues(alpha: 0.4) : _red.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isClear ? Icons.verified_outlined : Icons.account_balance_wallet_outlined,
                color: isClear ? _green : _red,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Total Tagihan Denda',
                style: TextStyle(color: _textGrey, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            isClear ? 'Rp 0' : AppFormatters.formatCurrency(outstanding),
            style: TextStyle(
              color: isClear ? _green : Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isClear
                ? 'Semua denda sudah lunas. Terima kasih!'
                : 'Lunasi denda agar tetap bisa meminjam buku baru.',
            style: const TextStyle(color: _textGrey, fontSize: 12),
          ),
          const SizedBox(height: 14),
          const Divider(color: _border, height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildMiniStat('Berjalan', _sum(running), _amber),
              ),
              Expanded(
                child: _buildMiniStat('Belum Dibayar', _sum(unpaid), _red),
              ),
              Expanded(
                child: _buildMiniStat('Sudah Dibayar', _sum(paid), _green),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, int amount, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.circle, color: color, size: 7),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: _textGrey, fontSize: 11),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          AppFormatters.formatCurrency(amount),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ---------- Tab ----------

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          for (int i = 0; i < _tabs.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedTab = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: i == _selectedTab ? _blue : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _tabs[i],
                    style: TextStyle(
                      color: i == _selectedTab ? Colors.white : _textGrey,
                      fontSize: 13,
                      fontWeight:
                          i == _selectedTab ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Tab "Belum Lunas": denda berjalan + denda belum dibayar
  List<Widget> _buildOutstandingTab(
    List<BorrowingItem> running,
    List<BorrowingItem> unpaid,
  ) {
    if (running.isEmpty && unpaid.isEmpty) {
      return [
        _buildEmpty(
          Icons.celebration_outlined,
          'Tidak ada denda',
          'Kamu tidak punya tagihan denda saat ini.',
        ),
      ];
    }

    return [
      if (unpaid.isNotEmpty) ...[
        _buildSectionTitle('Siap Dibayar', 'Buku sudah dikembalikan'),
        ...unpaid.map(_buildFineCard),
        const SizedBox(height: 8),
      ],
      if (running.isNotEmpty) ...[
        _buildSectionTitle('Denda Berjalan', 'Bertambah setiap hari'),
        ...running.map(_buildFineCard),
      ],
    ];
  }

  // Tab "Riwayat": denda yang sudah lunas
  List<Widget> _buildHistoryTab(List<BorrowingItem> paid) {
    if (paid.isEmpty) {
      return [
        _buildEmpty(
          Icons.receipt_long_outlined,
          'Belum ada riwayat',
          'Riwayat pembayaran denda akan muncul di sini.',
        ),
      ];
    }
    return paid.map(_buildFineCard).toList();
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Text(subtitle, style: const TextStyle(color: _textGrey, fontSize: 11.5)),
        ],
      ),
    );
  }

  // ---------- Kartu denda ----------

  Widget _buildFineCard(BorrowingItem item) {
    final status = item.fineStatus;
    final color = _fineColor(status);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _showFineDetail(item),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCover(item),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Terlambat ${item.lateDays} hari × '
                            '${AppFormatters.formatCurrency(BorrowingItem.finePerDay)}',
                            style: const TextStyle(color: _textGrey, fontSize: 12),
                          ),
                          const SizedBox(height: 8),
                          _buildStatusChip(status),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppFormatters.formatCurrency(item.fine),
                      style: TextStyle(
                        color: color,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: _bg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(_footerIcon(status), color: color, size: 15),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _footerText(item),
                          style: const TextStyle(color: _textGrey, fontSize: 11.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCover(BorrowingItem item) {
    final placeholder = Container(
      width: 44,
      height: 62,
      color: _border,
      child: const Icon(Icons.menu_book_rounded, color: _textGrey, size: 20),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: item.coverAsset == null
          ? placeholder
          : Image.asset(
              item.coverAsset!,
              width: 44,
              height: 62,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => placeholder,
            ),
    );
  }

  Widget _buildStatusChip(FineStatus status) {
    final color = _fineColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _fineLabel(status),
        style: TextStyle(color: color, fontSize: 10.5, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildEmpty(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Icon(icon, color: _textGrey.withValues(alpha: 0.6), size: 56),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: _textGrey, fontSize: 12.5)),
        ],
      ),
    );
  }

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
              'Denda keterlambatan '
              '${AppFormatters.formatCurrency(BorrowingItem.finePerDay)}/hari per buku. '
              'Denda berjalan terus bertambah sampai buku dikembalikan, '
              'lalu bisa dibayar lewat QRIS, Virtual Account, atau di loket.',
              style: const TextStyle(color: _textGrey, fontSize: 12, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Bar bayar di bawah ----------

  Widget _buildPayBar(List<BorrowingItem> unpaid) {
    final total = _sum(unpaid);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: const BoxDecoration(
          color: _cardBg,
          border: Border(top: BorderSide(color: _border)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${unpaid.length} denda siap dibayar',
                    style: const TextStyle(color: _textGrey, fontSize: 12),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppFormatters.formatCurrency(total),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _showPaymentSheet(unpaid),
              style: ElevatedButton.styleFrom(
                backgroundColor: _blue,
                foregroundColor: Colors.white,
                // Tema aplikasi memakai minimumSize lebar tak terbatas,
                // jadi di dalam Row harus diberi lebar minimum sendiri
                minimumSize: const Size(0, 48),
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Bayar Sekarang',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Detail denda ----------

  void _showFineDetail(BorrowingItem item) {
    final status = item.fineStatus;

    showModalBottomSheet(
      context: context,
      backgroundColor: _cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHandle(),
              const SizedBox(height: 16),
              _buildStatusChip(status),
              const SizedBox(height: 8),
              Text(
                item.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _sheetRow('ID Peminjaman', 'PJM-${item.id.toString().padLeft(5, '0')}'),
              _sheetRow('Batas Kembali', AppFormatters.formatDate(item.dueDate)),
              _sheetRow(
                'Tanggal Kembali',
                item.returnDate == null
                    ? 'Belum dikembalikan'
                    : AppFormatters.formatDate(item.returnDate!),
              ),
              _sheetRow('Keterlambatan', '${item.lateDays} hari'),
              _sheetRow(
                'Tarif',
                '${AppFormatters.formatCurrency(BorrowingItem.finePerDay)}/hari',
              ),
              if (status == FineStatus.paid) ...[
                _sheetRow('Dibayar', AppFormatters.formatDate(item.finePaidDate!)),
                _sheetRow('Metode', item.finePaymentMethod ?? '-'),
              ],
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(color: _border, height: 1),
              ),
              _sheetRow(
                'Total Denda',
                AppFormatters.formatCurrency(item.fine),
                valueColor: _fineColor(status),
                bold: true,
              ),
              const SizedBox(height: 16),
              if (status == FineStatus.unpaid)
                _fullButton('Bayar Denda Ini', _blue, () {
                  Navigator.pop(sheetContext);
                  _showPaymentSheet([item]);
                })
              else if (status == FineStatus.running)
                _fullButton('Lihat Daftar Peminjaman', _border, () {
                  Navigator.pop(sheetContext);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BorrowingListPage()),
                  ).then((_) => setState(() {}));
                }),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Pembayaran ----------

  void _showPaymentSheet(List<BorrowingItem> toPay) {
    final total = _sum(toPay);
    String selected = _methods.first.name;

    showModalBottomSheet(
      context: context,
      backgroundColor: _cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => StatefulBuilder(
        builder: (sheetContext, setSheetState) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHandle(),
                const SizedBox(height: 16),
                const Text(
                  'Pilih Metode Pembayaran',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${toPay.length} denda · ${AppFormatters.formatCurrency(total)}',
                  style: const TextStyle(color: _textGrey, fontSize: 12.5),
                ),
                const SizedBox(height: 16),
                for (final m in _methods)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => setSheetState(() => selected = m.name),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _bg,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: selected == m.name ? _blue : _border,
                            width: selected == m.name ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(m.icon, color: Colors.white70, size: 22),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    m.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.5,
                                    ),
                                  ),
                                  Text(
                                    m.description,
                                    style: const TextStyle(
                                        color: _textGrey, fontSize: 11.5),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              selected == m.name
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off,
                              color: selected == m.name ? _blue : _textGrey,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                _fullButton(
                  'Bayar ${AppFormatters.formatCurrency(total)}',
                  _blue,
                  () {
                    Navigator.pop(sheetContext);
                    _pay(toPay, selected);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Simulasi pembayaran (nanti diganti panggilan API)
  Future<void> _pay(List<BorrowingItem> toPay, String method) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    Navigator.pop(context); // tutup loading

    final total = _sum(toPay);
    setState(() {
      for (final item in toPay) {
        item.finePaidDate = BorrowingItem.today;
        item.finePaymentMethod = method;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Pembayaran ${AppFormatters.formatCurrency(total)} via $method berhasil',
        ),
        backgroundColor: _green,
      ),
    );
  }

  // ---------- Komponen kecil ----------

  Widget _buildHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: _border,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _sheetRow(String label, String value,
      {Color? valueColor, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(color: _textGrey, fontSize: 13)),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? Colors.white,
              fontSize: bold ? 15 : 13,
              fontWeight: bold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fullButton(String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(46),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Color _fineColor(FineStatus s) => switch (s) {
        FineStatus.running => _amber,
        FineStatus.unpaid => _red,
        FineStatus.paid => _green,
        FineStatus.none => _textGrey,
      };

  String _fineLabel(FineStatus s) => switch (s) {
        FineStatus.running => 'Berjalan',
        FineStatus.unpaid => 'Belum Dibayar',
        FineStatus.paid => 'Lunas',
        FineStatus.none => 'Tanpa Denda',
      };

  IconData _footerIcon(FineStatus s) => switch (s) {
        FineStatus.running => Icons.schedule,
        FineStatus.unpaid => Icons.payments_outlined,
        FineStatus.paid => Icons.check_circle_outline,
        FineStatus.none => Icons.info_outline,
      };

  String _footerText(BorrowingItem item) => switch (item.fineStatus) {
        FineStatus.running =>
          'Belum dikembalikan · bertambah ${AppFormatters.formatCurrency(BorrowingItem.finePerDay)} tiap hari',
        FineStatus.unpaid =>
          'Dikembalikan ${AppFormatters.formatDate(item.returnDate!)} · menunggu pembayaran',
        FineStatus.paid =>
          'Dibayar ${AppFormatters.formatDate(item.finePaidDate!)} via ${item.finePaymentMethod ?? '-'}',
        FineStatus.none => '-',
      };
}

class _PaymentMethod {
  final String name;
  final String description;
  final IconData icon;

  const _PaymentMethod(this.name, this.description, this.icon);
}
