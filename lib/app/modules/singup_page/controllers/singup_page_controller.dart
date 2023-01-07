import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:singal_chat_app/Models/userModels.dart';

class SingupPageController extends GetxController {
  Rx<TextEditingController> NameController = TextEditingController().obs;
  Rx<TextEditingController> EmailController = TextEditingController().obs;
  Rx<TextEditingController> PassController = TextEditingController().obs;
  Rx<TextEditingController> ConformPassController = TextEditingController().obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxString mtoken = ''.obs;

  @override
  void onInit() {
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
