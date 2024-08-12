// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:save_me_new/Component/login_text_field.dart';
import 'package:save_me_new/app/models/report.dart';
import 'package:save_me_new/app/modules/report_page/controllers/report_page_controller.dart';
import 'package:save_me_new/component/GlobalFunction.dart';
import 'package:save_me_new/component/MyButtonNext.dart';
import 'package:save_me_new/component/my_text.dart';
import 'package:save_me_new/component/theme.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

final firebase_storage.FirebaseStorage _storage =
    firebase_storage.FirebaseStorage.instance;

class Report2 extends StatefulWidget {
  const Report2({
    super.key,
    required this.name,
    required this.noTelp,
    // required this.email,
  });
  final String name;
  final String noTelp;
  // final String email;
  @override
  State<Report2> createState() => _Report2State();
}

class _Report2State extends State<Report2> {
  ReportPageController controller = ReportPageController();
  List<String> jenkel = ["Pria", "Wanita"];
  String selectedJenkel = "Pria";
  String? fileName;
  String _textValue = 'No file selected';

  @override
  Widget build(BuildContext context) {
    String jenisKelamin = selectedJenkel;
    String getFileName;
    File? fileToUpload;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Save Me | Report',
          style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Victim Informations",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Heading1(
                    "Age",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: formreport,
                      filled: true,
                    ),
                    controller: controller.age,
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Heading1("Gender ",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                        color: formreport,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                          ),
                        ]),
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
                                child: Mytext(
                                  value,
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedJenkel =
                              value!; // Load product data based on the selected vendor.
                        });
                        jenisKelamin = selectedJenkel;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Heading1("Home Address ",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                  const SizedBox(
                    height: 3,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      fillColor: formreport,
                      filled: true,
                    ),
                    controller: controller.homeaddress,
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Heading1("What happened? Be spesific",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                  const SizedBox(
                    height: 3,
                  ),
                  LoginTextField(
                    height: getLength("width", context) * 40 / 100,
                    color: formreport,
                    controller: controller.spesific,
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Heading1("Evidence",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                  const SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    width: getLength("width", context),
                    child: Row(
                      children: [
                        MyButtonNext(
                          onPressed: () async {
                            try {
                              FilePickerResult? result = await FilePicker
                                  .platform
                                  .pickFiles(type: FileType.image);
                              if (result != null) {
                                fileToUpload = File(result.files.single.path!);
                                getFileName =
                                    'file_${fileToUpload?.path.split('/').last}';
                                firebase_storage.Reference ref = _storage
                                    .ref()
                                    .child('Files')
                                    .child(getFileName);
                                fileName = getFileName;
                                await ref.putFile(fileToUpload!);
                                // print('File uploaded successfully!');

                                setState(() {
                                  if (fileName != null) {
                                    _textValue = fileName!;
                                  }
                                });
                              } else {
                                // User canceled file picking
                                fileName = "";
                              }
                            } catch (e) {
                              // print('Error uploading file: $e');
                            }
                          },
                          text: "File",
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Text(_textValue),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyButtonNext(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: "Prev",
                          color: PRIMARY_COLOR),
                      MyButtonNext(
                        onPressed: () async {
                          String uid = FirebaseAuth.instance.currentUser!.uid;
                          int count = await controller.getDocumentCount();
                          int id = count + 1;
                          String? file = fileName;
                          if (controller.age.value.text.isNotEmpty &&
                              controller.homeaddress.value.text.isNotEmpty &&
                              controller.spesific.value.text.isNotEmpty) {
                            Report addNewReport = Report(
                              id: id,
                              uid: uid,
                              nama: widget.name,
                              telepon: int.tryParse(widget.noTelp),
                              // email: widget.email,
                              umur: int.tryParse(controller.age.text),
                              jenisKelamin: jenisKelamin,
                              alamat: controller.homeaddress.text,
                              spesifik: controller.spesific.text,
                              file: file,
                              status: 'process',
                              result: '',
                            );
                            controller.addReport(addNewReport);
                          } else {
                            if (!mounted) return;
                            mySnackBar(
                              context,
                              text: "Fill in all forms",
                              color: PRIMARY_COLOR,
                            );
                          }
                        },
                        text: "Send",
                        color: PRIMARY_COLOR,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
