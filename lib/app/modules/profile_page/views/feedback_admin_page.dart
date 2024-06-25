import 'package:flutter/material.dart';
import 'package:save_me_new/component/GlobalFunction.dart';

class FeedbackAdminPage extends StatelessWidget {
  const FeedbackAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Save Me | Feedback',
          style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.bold),
        ),
      ),
      body: const Center(
        child: Text('data'),
      ),
    );
  }
}
