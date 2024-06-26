import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_me_new/app/models/webinar.dart';
import 'package:save_me_new/app/modules/auth/auth_service.dart';
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
  final AuthService _authService = AuthService();
  @override
  void initState() {
    super.initState();
    _webinar = widget.webinar;
  }

  @override
  Widget build(BuildContext context) {
    final WebinarPageController webinarPageController = WebinarPageController();
    final bool showAdminButton = Get.arguments['button'];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Save Me | Webinar',
          style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.bold),
        ),
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView(
        children: [
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
                Row(
                  children: [
                    const Icon(Icons.timer),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      _webinar.time,
                      style: kTitleTextStyle,
                    ),
                  ],
                ),
                Text(
                  _webinar.longDesc,
                  style: kLongDescTextStyle,
                ),
                const SizedBox(height: 16),
                Visibility(
                  visible: !showAdminButton,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                      foregroundColor: kTextColor,
                    ),
                    onPressed: () {
                      String uid = _authService.getCurrentUser()!.uid;
                      String webinarId = _webinar.docId;
                      webinarPageController.registerWebinar(uid, webinarId);
                    },
                    child: const Text('Daftar'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
