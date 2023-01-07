import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:singal_chat_app/Models/userModels.dart';
import 'package:singal_chat_app/app/modules/login_page/controllers/login_page_controller.dart';
import 'package:singal_chat_app/app/routes/app_pages.dart';
import 'package:singal_chat_app/constants/api_constants.dart';
import 'package:singal_chat_app/constants/color_constant.dart';
import 'package:singal_chat_app/constants/sizeConstant.dart';
import 'package:singal_chat_app/constants/text_field.dart';
import 'package:singal_chat_app/service/Firebase_service.dart';

import '../../../../main.dart';

class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('LogIn '),
        backgroundColor: appTheme.appbarTheme,
        centerTitle: true,
      ),
      body: Container(
        height: MySize.screenHeight,
        width: MySize.screenWidth,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Space.height(150),
                  Center(
                      child: Text(
                    "Log In",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: appTheme.appbarTheme,
                        fontSize: 25),
                  )),
                  Space.height(50),
                  getTextField(
                      borderColor: appTheme.appbarTheme,
                      textEditingController: controller.EmailController.value,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: appTheme.appbarTheme,
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      labelText: "Email",
                      validation: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Email";
                        }
                        return null;
                      },
                      hintText: "Enter Email here"),
                  SizedBox(
                    height: MySize.getHeight(40),
                  ),
                  getTextField(
                    borderColor: appTheme.appbarTheme,
                    labelText: "Password",
                    textEditingController: controller.PassController.value,
                    validation: (val) {
                      if (val!.isEmpty) {
                        return "Please enter password";
                      } else if (val.length < 6) {
                        return "Digits must be greater than 6 character";
                      }
                      return null;
                    },
                  ),
                  Space.height(50),
                  GestureDetector(
                    onTap: () async {
                      await FirebaseService()
                          .loginUser(
                              context: context,
                              userModels: UserModels(
                                FriendsList: [],
                                Name: "",
                                Email: controller.EmailController.value.text,
                                Password: controller.PassController.value.text,
                                uid: "",
                              ))
                          .then((value) {
                        if (!isNullEmptyOrFalse(value)) {
                          Get.offAllNamed(Routes.HOME);
                          box.write(ArgumentConstant.isLogin, true);
                        }
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: appTheme.appbarTheme,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                          child: Text(
                        "Log In",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  Space.height(30),
                  GestureDetector(
                      onTap: () {
                        Get.offAndToNamed(Routes.SINGUP_PAGE);
                      },
                      child: Center(
                          child: Text(
                        "Sing Up?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: appTheme.appbarTheme),
                      ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
