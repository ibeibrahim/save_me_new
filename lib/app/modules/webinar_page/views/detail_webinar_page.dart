import 'package:flutter/material.dart';
import 'package:save_me_new/app/models/webinar.dart';
import 'package:save_me_new/app/modules/webinar_page/controllers/webinar_page_controller.dart';
import 'package:save_me_new/component/GlobalFunction.dart';

class DetailWebinarPage extends StatefulWidget {
  const DetailWebinarPage({
    super.key,
    required this.webinar,
  });
  final Webinar webinar;
  @override
  State<DetailWebinarPage> createState() => _DetailWebinarPageState();
}

class _DetailWebinarPageState extends State<DetailWebinarPage> {
  final WebinarPageController controller = WebinarPageController();
  late Webinar _webinar;
  @override
  void initState() {
    super.initState();
    _webinar = widget.webinar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Save Me | Webinar',
            style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.bold),
          ),
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
                FutureBuilder<ImageProvider>(
                  future: controller.getImageProvider(_webinar.filename),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ClipRRect(
                        borderRadius: BorderRadius.zero,
                        child: Image(
                          image: snapshot.data!,
                          fit: BoxFit.cover,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Icon(Icons.error);
                    } else {
                      return const Text('Loading...');
                    }
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Webinar : ${_webinar.title}',
                  style: kTitleTextStyle,
                ),
                Row(
                  children: [
                    const Icon(Icons.date_range),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      _webinar.dateTime,
                      style: kTitleTextStyle,
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Icon(Icons.timer),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '09.00 - 12.00',
                      style: kTitleTextStyle,
                    ),
                  ],
                ),
                Text(
                  _webinar.longDesc,
                  style: kLongDescTextStyle,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                    foregroundColor: kTextColor,
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
