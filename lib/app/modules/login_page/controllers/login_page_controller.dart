import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:singal_chat_app/app/routes/app_pages.dart';

class LoginPageController extends GetxController {
  Rx<TextEditingController> EmailController = TextEditingController().obs;
  Rx<TextEditingController> PassController = TextEditingController().obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void onInit() {
    EmailController.value.text = "thummar0211@gmail.com";
    PassController.value.text = "Test@123";
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
