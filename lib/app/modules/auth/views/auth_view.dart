import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:save_me_new/app/routes/app_pages.dart';
import 'package:save_me_new/component/MyButton.dart';
import 'package:save_me_new/component/my_text.dart';
import 'package:save_me_new/component/GlobalFunction.dart';

import '../controllers/auth_controller.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  var isLogin = false.obs;
  bool inTheSacondPageOfRegister = false;
  List<String> jenkel = ["Pria", "Wanita"];
  String selectedJenkel = "Pria";

  void goToSecondPageOfRegister() {
    setState(() {
      inTheSacondPageOfRegister = true;
    });
  }

  void goToFirstPageOfRegister() {
    setState(() {
      inTheSacondPageOfRegister = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    authController.jenisKelaminRegisterController = selectedJenkel;
    return Scaffold(
        backgroundColor: PRIMARY_COLOR,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Image.asset(
                      "assets/images/logo.png",
                      height: 100,
                    ),
                    isLogin.value ? loginWidget() : registerWidget()
                  ],
                )),
          ),
        ));
  }

  Widget registerWidget() {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Mytext(
                          "Register",
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
                // Form
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (!inTheSacondPageOfRegister)
                      ? [
                          const Text(
                            "Email",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          TextFormField(
                            controller: authController.emailRegisterController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              if (!value.contains('.')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              errorStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Heading1("Nama",
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.white),
                          const SizedBox(
                            height: 3,
                          ),
                          TextFormField(
                            controller: authController.namaRegisterController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Nama",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              errorStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Heading1("Jenis Kelamin",
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.white),
                          const SizedBox(
                            height: 3,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButtonFormField(
                              isExpanded: false,
                              value: selectedJenkel,
                              padding: const EdgeInsets.all(0),
                              decoration: InputDecoration(
                                labelText: "",
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none),
                              ),
                              items: jenkel
                                  .map((value) => DropdownMenuItem(
                                        value: value,
                                        child: Mytext(value,
                                            color: Colors.black, fontSize: 16),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(
                                  () {
                                    selectedJenkel =
                                        value!; // Load product data based on the selected vendor.
                                  },
                                );
                                authController.jenisKelaminRegisterController =
                                    selectedJenkel;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Heading1("Tempat tanggal lahir",
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.white),
                          const SizedBox(
                            height: 3,
                          ),
                          GestureDetector(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1945),
                                  lastDate: DateTime.now());
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  authController.tanggalLahirRegisterController
                                      .text = formattedDate;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                            child: TextFormField(
                              enabled: false,
                              controller:
                                  authController.tanggalLahirRegisterController,
                              keyboardType: TextInputType.datetime,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Tanggal Lahir",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                errorStyle:
                                    const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Heading1("No Telp",
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.white),
                          const SizedBox(
                            height: 3,
                          ),
                          TextFormField(
                            controller: authController.noTelpRegisterController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "No Telp",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              errorStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 20)
                        ]
                      : [
                          const SizedBox(
                            height: 10,
                          ),
                          const Heading1(
                            "No Darurat",
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          TextFormField(
                            controller:
                                authController.noDaruratRegisterController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "No Darurat",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              errorStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Heading1("Username",
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.white),
                          const SizedBox(
                            height: 3,
                          ),
                          TextFormField(
                            controller:
                                authController.usernameRegisterController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Username",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              errorStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Heading1("Password",
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.white),
                          const SizedBox(
                            height: 3,
                          ),
                          TextFormField(
                            controller:
                                authController.passwordRegisterController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              errorStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Heading1("Re-password",
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.white),
                          const SizedBox(
                            height: 3,
                          ),
                          TextFormField(
                            controller:
                                authController.rePasswordRegisterController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              if (value !=
                                  authController
                                      .passwordRegisterController.value.text) {
                                return 'Password not match';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              errorStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                ),
                Row(
                  children: [
                    // const SizedBox(
                    //   height: 16,
                    // ),

                    (!inTheSacondPageOfRegister)
                        ? ElevatedButton(
                            // backgroundColor: SECONDARY_COLOR,
                            child: const Text(
                              "Login",
                              style: const TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 1, 62, 111),
                            ),
                            onPressed: () {
                              isLogin.value = true;
                            },
                          )
                        : ElevatedButton(
                            // backgroundColor: SECONDARY_COLOR,
                            child: const Text(
                              "Back",
                              style: const TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 1, 62, 111),
                            ),
                            onPressed: goToFirstPageOfRegister,
                          ),
                    const Spacer(),
                    inTheSacondPageOfRegister
                        ? ElevatedButton(
                            // backgroundColor: SECONDARY_COLOR,
                            child: const Text(
                              "Register",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 1, 62, 111),
                            ),
                            onPressed: () async {
                              var registerSuccess =
                                  await authController.handleRegister();
                              if (registerSuccess) {
                                authController.postRegisterDetails();
                                Get.offAllNamed(Routes.HOME_LAYOUT);
                              }
                            },
                          )
                        : ElevatedButton(
                            // backgroundColor: SECONDARY_COLOR,
                            child: const Text(
                              "Next",
                              style: const TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 1, 62, 111),
                            ),
                            onPressed: goToSecondPageOfRegister,
                          ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget loginWidget() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //Container Logo Login
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Mytext(
                      "Login",
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Mytext(
                      "Sign in with your data that you entered during your registration.",
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              // Form
              const Heading1(
                "Email",
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.white,
              ),
              const SizedBox(
                height: 3,
              ),
              TextFormField(
                controller: authController.emailLoginController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Heading1("Password",
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.white),
              const SizedBox(
                height: 3,
              ),
              TextFormField(
                controller: authController.passwordLoginController,
                obscureText: true,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Mytext(
                      "Lupa Password?",
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              MyButton(
                backgroundColor: SECONDARY_COLOR,
                text: "Login",
                onPressed: authController.handleLogin,
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                backgroundColor: SECONDARY_COLOR,
                text: "Register",
                onPressed: () {
                  isLogin.value = false;
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
