import 'package:flutter/material.dart';
import 'package:library_mobile/data/models/sample_model.dart';

// Halaman rincian informasi buku
class DetailView extends StatelessWidget {
  final SampleModel? book;

  const DetailView({super.key, this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: const Center(
        child: Text('Page ini belum dibuat'),
      ),
    );
  }
}
