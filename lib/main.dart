import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:save_me_new/firebase_options.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  // Ensure that Firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Run the application :)
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
