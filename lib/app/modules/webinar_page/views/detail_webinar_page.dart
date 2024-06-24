import 'package:flutter/material.dart';

class DetailWebinarPage extends StatelessWidget {
  const DetailWebinarPage({
    super.key,
    required this.title,
    required this.longDescription,
  });
  final String title;
  final String imgLink =
      'https://images.unsplash.com/photo-1718551260047-e5b4a92e46b6?q=80&w=2667&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  final String pembicara = 'Pembicara';
  final String longDescription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DetailWebinarPage'),
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  imgLink,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16),
                const Text('Judul'),
                const Text('Deskripsi'),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[200],
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {},
                  child: const Text('Daftar'),
                )
              ],
            ),
          ),
        ]));
  }
}
