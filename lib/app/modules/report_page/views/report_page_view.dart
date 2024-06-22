import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:save_me_new/app/modules/report_page/views/report_page2.dart';
import 'package:save_me_new/component/GlobalFunction.dart';
import 'package:save_me_new/component/MyButtonNext.dart';
import 'package:save_me_new/component/MyText.dart';
import 'package:save_me_new/component/login_text_field.dart';
import 'package:save_me_new/component/theme.dart';

import '../controllers/report_page_controller.dart';

class ReportPageView extends GetView<ReportPageController> {
  const ReportPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReportPageController controller = Get.put(ReportPageController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('ReportPageView'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Heading1(
                      "Name of complainant",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    LoginTextField(
                      color: formreport,
                      controller: controller.nameOfCompainant,
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Heading1("Telephone number ",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                    const SizedBox(
                      height: 3,
                    ),
                    LoginTextField(
                      color: formreport,
                      controller: controller.telephoneNumber,
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Heading1("Email ",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                    const SizedBox(
                      height: 3,
                    ),
                    LoginTextField(
                      color: formreport,
                      controller: controller.emailController,
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyButtonNext(
                          onPressed: () {
                            if (controller.nameOfCompainant.text.isNotEmpty &&
                                controller.telephoneNumber.text.isNotEmpty &&
                                controller.emailController.text.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Report2(
                                      name: controller.nameOfCompainant.text,
                                      email: controller.emailController.text,
                                      noTelp: controller.telephoneNumber.text,
                                    );
                                  },
                                ),
                              );
                            } else {
                              MySnackbar(
                                context,
                                text: "Fill in all forms",
                                color: PRIMARY_COLOR,
                              );
                            }
                          },
                          text: "Next",
                          color: secondColor,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
