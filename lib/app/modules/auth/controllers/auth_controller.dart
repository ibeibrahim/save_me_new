import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:save_me_new/app/modules/auth/auth_service.dart';
import 'package:save_me_new/app/modules/home_layout/views/home_layout_view.dart';

class AuthController extends GetxController {
  //Login Text Controller
  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();
  // Register Text Controller
  TextEditingController emailRegisterController = TextEditingController();
  TextEditingController namaRegisterController = TextEditingController();
  late String jenisKelaminRegisterController;
  TextEditingController tanggalLahirRegisterController =
      TextEditingController();
  TextEditingController noTelpRegisterController = TextEditingController();
  TextEditingController noDaruratRegisterController = TextEditingController();
  TextEditingController usernameRegisterController = TextEditingController();
  TextEditingController passwordRegisterController = TextEditingController();
  TextEditingController rePasswordRegisterController = TextEditingController();

  Future<void> handleLogin() async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(
        emailLoginController.text,
        passwordLoginController.text,
      );
      Get.offAll(() => HomeLayoutView());
    } catch (e) {
      // Text(e.toString());
      Get.defaultDialog(title: e.toString());
    }
  }

  Future<bool> handleRegister() async {
    final authService = AuthService();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailRegisterController.text,
        password: passwordRegisterController.text,
      );
      await authService.signInWithEmailPassword(
        emailRegisterController.text,
        passwordRegisterController.text,
      );
      return true;
    } catch (e) {
      if (e is FirebaseAuthException) {
        Get.showSnackbar(GetSnackBar(
          message: e.toString(),
        ));
      }
    }
    return false;
  }

  Future postRegisterDetails() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('user');

    String newDocId = FirebaseAuth.instance.currentUser?.uid ?? '';
    DocumentReference newDocRef =
        FirebaseFirestore.instance.collection('user').doc(newDocId);
    newDocRef.set({'exist': true}).onError(
        (e, _) => print("Error writing document: $e"));
    Map<String, dynamic> userData = {
      'docId': newDocId,
      'uid': FirebaseAuth.instance.currentUser?.uid,
      'username': usernameRegisterController.text,
      'name': namaRegisterController.text,
      'gender': jenisKelaminRegisterController,
      'birtDate': tanggalLahirRegisterController.text,
      'mobileNumber': noTelpRegisterController.text,
      'urgentNumber': noDaruratRegisterController.text,
    };
    try {
      await users.doc(newDocId).set(userData);
      // User document created successfully
    } on FirebaseException catch (e) {
      // Handle errors

      Get.defaultDialog(title: e.message.toString());
    }
  }

  Future<void> handleLogout() async {
    final auth = AuthService();
    auth.signOut();
  }
}
