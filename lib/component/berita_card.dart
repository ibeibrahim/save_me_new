import 'package:flutter/material.dart';

class BeritaCard extends StatelessWidget {
  const BeritaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          "assets/images/kompasimg.png",
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "2017 Ada 12 Kasus Pelecehan Seksual di KRL",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/kompasicon.png",
              width: 10,
            ),
            const SizedBox(
              width: 5,
            ),
            const Text("Kompas.com"),
            const SizedBox(
              width: 5,
            ),
            Image.asset(
              "assets/images/verified.png",
              width: 10,
            ),
          ],
        ),
      ],
    );
  }
}
