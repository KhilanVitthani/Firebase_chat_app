import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:singal_chat_app/Models/userModels.dart';
import 'package:singal_chat_app/app/routes/app_pages.dart';
import 'package:singal_chat_app/constants/color_constant.dart';
import 'package:singal_chat_app/constants/sizeConstant.dart';
import 'package:singal_chat_app/constants/text_field.dart';
import 'package:singal_chat_app/service/Firebase_service.dart';

import '../controllers/singup_page_controller.dart';

class SingupPageView extends GetWidget<SingupPageController> {
  const SingupPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('SING UP'),
            centerTitle: true,
            backgroundColor: appTheme.appbarTheme,
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
                      Space.height(50),
                      Center(
                          child: Text(
                        "Chat App",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: appTheme.appbarTheme,
                            fontSize: 25),
                      )),
                      Space.height(50),
                      getTextField(
                          borderColor: appTheme.appbarTheme,
                          textEditingController:
                              controller.NameController.value,
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: appTheme.appbarTheme,
                          ),
                          textCapitalization: TextCapitalization.sentences,
                          labelText: "Name",
                          validation: (val) {
                            if (val!.isEmpty) {
                              return "Please Enter Name";
                            }
                            return null;
                          },
                          hintText: "Enter name here"),
                      SizedBox(
                        height: MySize.getHeight(40),
                      ),
                      getTextField(
                          borderColor: appTheme.appbarTheme,
                          textEditingController:
                              controller.EmailController.value,
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
                      SizedBox(
                        height: MySize.getHeight(40),
                      ),
                      getTextField(
                          borderColor: appTheme.appbarTheme,
                          labelText: "Confirm Password",
                          validation: (val) {
                            if (val!.isEmpty) return 'Please enter password';
                            if (val != controller.PassController.value.text)
                              return 'Not match both password';
                            return null;
                          },
                          textEditingController:
                              controller.ConformPassController.value),
                      Space.height(50),
                      GestureDetector(
                        onTap: () async {
                          await FirebaseService()
                              .SingUpUser(
                            context: context,
                            userModels: UserModels(
                              FriendsList: [],
                              Name: controller.NameController.value.text.trim(),
                              Password:
                                  controller.PassController.value.text.trim(),
                              uid: "",
                              Email:
                                  controller.EmailController.value.text.trim(),
                            ),
                          )
                              .then((value) {
                            if (!isNullEmptyOrFalse(value)) {
                              Get.offAllNamed(Routes.HOME);
                            }
                          });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: appTheme.appbarTheme,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                              child: Text(
                            "SING UP",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      Space.height(30),
                      GestureDetector(
                          onTap: () {
                            Get.offAndToNamed(Routes.LOGIN_PAGE);
                          },
                          child: Center(
                              child: Text(
                            "Log In?",
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
          )),
    );
  }
}
