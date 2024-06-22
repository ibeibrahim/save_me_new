import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:save_me_new/Component/MyTextField.dart';
import 'package:save_me_new/component/GlobalFunction.dart';
import 'package:save_me_new/component/MyButtonNext.dart';
import 'package:save_me_new/component/MyText.dart';
import 'package:save_me_new/component/theme.dart';

class Report2 extends StatefulWidget {
  const Report2(
      {super.key,
      required this.name,
      required this.noTelp,
      required this.email});
  final String name;
  final String noTelp;
  final String email;

  @override
  State<Report2> createState() => _Report2State();
}

class _Report2State extends State<Report2> {
  var age = TextEditingController();
  var gender = TextEditingController();
  var homeaddress = TextEditingController();
  var spesific = TextEditingController();
  // PlatformFile? pickedFile;

  List<String> jenkel = ["Pria", "Wanita"];
  String selectedJenkel = "Pria";

  // Future<void> selectFile() async {
  //   final result = await FilePicker.platform.pickFiles(type: FileType.image);
  //   setState(
  //     () {
  //       pickedFile = result?.files.first;
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReportPageView'),
        centerTitle: true,
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
                  Heading1(
                    "Age",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  LoginTextField(
                    color: formreport,
                    controller: age,
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Heading1("Gender ",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: formreport,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1, 1),
                            blurRadius: 2,
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
                                child: MyText(
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
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Heading1("Home Address ",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                  const SizedBox(
                    height: 3,
                  ),
                  LoginTextField(
                    color: formreport,
                    controller: homeaddress,
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Heading1("What happened? Be spesific",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                  const SizedBox(
                    height: 3,
                  ),
                  LoginTextField(
                    height: getLength("width", context) * 40 / 100,
                    color: formreport,
                    controller: spesific,
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Heading1("Evidence",
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
                          onPressed: () {
                            // selectFile();
                          },
                          text: "File",
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: MyText("No file selected"),
                        )
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
                          color: secondColor),
                      MyButtonNext(
                        onPressed: () {
                          // if (age.value.text.isNotEmpty &&
                          //     homeaddress.value.text.isNotEmpty &&
                          //     spesific.value.text.isNotEmpty &&
                          //     pickedFile != null) {
                          //   Report().createReport(
                          //     widget.name,
                          //     widget.noTelp,
                          //     widget.email,
                          //     age.value.text,
                          //     selectedJenkel,
                          //     homeaddress.value.text,
                          //     spesific.value.text,
                          //     pickedFile!,
                          //     context,
                          //   );
                          // } else {
                          //   MySnackbar(
                          //     context,
                          //     text: "Fill in all forms",
                          //     color: PRIMARY_COLOR,
                          //   );
                          // }
                        },
                        text: "Send",
                        color: secondColor,
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
