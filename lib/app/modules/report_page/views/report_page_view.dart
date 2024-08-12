import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:save_me_new/app/modules/report_page/views/report_page2.dart';
import 'package:save_me_new/component/GlobalFunction.dart';
import 'package:save_me_new/component/MyButtonNext.dart';
import 'package:save_me_new/component/my_text.dart';
import 'package:save_me_new/component/theme.dart';

import '../controllers/report_page_controller.dart';

class ReportPageView extends GetView<ReportPageController> {
  const ReportPageView({super.key});

  @override
  Widget build(BuildContext context) {
    ReportPageController controller = Get.put(ReportPageController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Save Me | Report',
          style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              margin: const EdgeInsets.fromLTRB(30, 5, 30, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/reportingimg.jpg",
                    width: getLength("width", context) * 90 / 100,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Complainant Informations",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Heading1(
                    "Name of complainant",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      fillColor: formreport,
                      filled: true,
                    ),
                    controller: controller.nameOfCompainant,
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Heading1("Telephone number ",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                  const SizedBox(
                    height: 3,
                  ),
                  TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      fillColor: formreport,
                      filled: true,
                    ),
                    controller: controller.telephoneNumber,
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // const Heading1("Email ",
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 16,
                  //     color: Colors.black),
                  // const SizedBox(
                  //   height: 3,
                  // ),
                  // TextField(
                  //   keyboardType: TextInputType.emailAddress,
                  //   decoration: InputDecoration(
                  //     fillColor: formreport,
                  //     filled: true,
                  //   ),
                  //   controller: controller.emailController,
                  //   obscureText: false,
                  // ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MyButtonNext(
                        onPressed: () {
                          if (controller.nameOfCompainant.text.isNotEmpty &&
                              controller.telephoneNumber.text.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Report2(
                                    name: controller.nameOfCompainant.text,
                                    // email: controller.emailController.text,
                                    noTelp: controller.telephoneNumber.text,
                                  );
                                },
                              ),
                            );
                          } else {
                            mySnackBar(
                              context,
                              text: "Fill in all forms",
                              color: PRIMARY_COLOR,
                            );
                          }
                        },
                        text: "Next",
                        color: PRIMARY_COLOR,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
