import 'package:flutter/material.dart';

class DetailWebinarPage extends StatefulWidget {
  const DetailWebinarPage({super.key});

  @override
  State<DetailWebinarPage> createState() => _DetailWebinarPageState();
}

class _DetailWebinarPageState extends State<DetailWebinarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Webinar'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const Text('Judul Webinar'),
          const Text('Deskripsi panjang'),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Daftar ke Webinar'),
          )
        ],
      ),
    );
  }
}
