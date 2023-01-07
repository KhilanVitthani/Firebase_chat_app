import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:singal_chat_app/Models/userModels.dart';
import 'package:singal_chat_app/constants/api_constants.dart';
import 'package:singal_chat_app/constants/sizeConstant.dart';
import 'package:singal_chat_app/main.dart';
import 'package:singal_chat_app/service/Firebase_service.dart';

import '../../../../service/notification_service.dart';

class HomeController extends GetxController {
  UserModels? userData;
  RxString username = "".obs;
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      userData = await FirebaseService().getUserData(
          uid: box.read(ArgumentConstant.userUid), context: Get.context!);
      if (!isNullEmptyOrFalse(userData)) {
        username.value = userData!.Name.toString();
        box.write(ArgumentConstant.userName, username.value);
        String fcmToken = await NotificationService().getFcmToken();
        if (!isNullEmptyOrFalse(fcmToken)) {
          FirebaseService().updateFcmToken(fcmToken: fcmToken);
        }
      }
    });
    requestPermission();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print(' User granted permission ');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print(' User granted provisional permission ');
    } else {
      print(' User declined or has not accepted permission ');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
