import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:save_me_new/app/modules/auth/views/auth_view.dart';
import 'package:save_me_new/app/modules/home_layout/views/home_layout_view.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeLayoutView();
          } else {
            return const AuthView();
          }
        },
      ),
    );
  }
}
