import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:singal_chat_app/Models/userModels.dart';
import 'package:singal_chat_app/service/Firebase_service.dart';

import '../app/routes/app_pages.dart';
import '../constants/api_constants.dart';
import '../constants/sizeConstant.dart';
import '../main.dart';

class NotificationService {
  Future<void> init(
      FlutterLocalNotificationsPlugin aflutterLocalNotificationsPlugin) async {
    if (!isFlutterLocalNotificationInitialize) {
      var androidInitialize =
          AndroidInitializationSettings('notification_icon');
      var iosInitialize = DarwinInitializationSettings();
      var initializationSettings = InitializationSettings(
          android: androidInitialize, iOS: iosInitialize);
      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse:
              (NotificationResponse response) async {
        print(response);
        if (!isNullEmptyOrFalse(response.payload)) {
          await getNavigateToChatScreen(
              userId: jsonDecode(response.payload!)["N_SENDER_ID"]);
        }
      });
      await initServices();
      await getFcmToken();
    }

    isFlutterLocalNotificationInitialize = true;
  }

  Future<String> getFcmToken() async {
    String fcmToken = "";

    if (Platform.isAndroid) {
      fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
      print("Token=============" + fcmToken);
    } else {
      fcmToken = await FirebaseMessaging.instance.getAPNSToken() ?? "";
    }
    return fcmToken;
  }

  initServices() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      sound: false,
      badge: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (!isNullEmptyOrFalse(value)) {
        showNotification(remoteMessage: value!);
      }
    });
    //when app is open
    FirebaseMessaging.onMessage.listen((value) {
      if (!isNullEmptyOrFalse(value)) {
        showNotification(remoteMessage: value);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((value) async {
      if (!isNullEmptyOrFalse(value)) {
        print("OnTap := ${value.data["N_SENDER_ID"]}");
        await getNavigateToChatScreen(userId: value.data["N_SENDER_ID"]);
      }
    });
  }

  void showNotification({required RemoteMessage remoteMessage}) {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      "androidChannel01",
      "androidChannel",
      description: "Android Channel Description",
      // sound: RawResourceAndroidNotificationSound("notification"),
    );
    if (!isNullEmptyOrFalse(remoteMessage.notification)) {
      print("+++++++++++>>>>>>>>>>>>>>>>>");
      flutterLocalNotificationsPlugin.show(
        0,
        remoteMessage.notification!.title,
        remoteMessage.notification!.body,
        payload: jsonEncode(remoteMessage.data),
        NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              // sound: channel.sound,
              importance: Importance.max,
              ongoing: false,
              channelDescription: channel.description,
              playSound: false,
              priority: Priority.high,
              color: Colors.teal,
              icon: "notification_icon"),
        ),
      );
    }
  }

  getNavigateToChatScreen({required String userId}) async {
    UserModels? userModel =
        await FirebaseService().getUserData(uid: userId, context: Get.context!);
    if (!isNullEmptyOrFalse(userModel)) {
      Get.offAllNamed(Routes.CHAT_SCREEN, arguments: {
        ArgumentConstant.friendData: userModel,
        ArgumentConstant.isFromNotification: true,
      });
    }
  }
}
