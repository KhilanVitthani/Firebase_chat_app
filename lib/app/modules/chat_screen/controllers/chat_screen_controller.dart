import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:singal_chat_app/constants/api_constants.dart';
import 'package:singal_chat_app/constants/sizeConstant.dart';
import 'package:http/http.dart' as http;
import '../../../../Models/chat_data_model.dart';
import '../../../../Models/userModels.dart';
import '../../../../main.dart';

class ChatScreenController extends GetxController {
  UserModels? friendData;
  Rx<TextEditingController> chatController = TextEditingController().obs;
  RxList<ChatDataModel> chatDataList = RxList<ChatDataModel>([]);

  @override
  void onInit() {
    if (!isNullEmptyOrFalse(Get.arguments)) {
      friendData = Get.arguments[ArgumentConstant.friendData];
      print(friendData!.uid);
    }
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

  String getChatId() {
    List<String> uids = [
      box.read(ArgumentConstant.userUid),
      friendData!.uid.toString()
    ];
    uids.sort((uid1, uid2) => uid1.compareTo(uid2));
    return uids.join("_chat_");
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAeHUJjMM:APA91bFdesGMnOwy9svZ36bw6Pt34Td7B2LKjNVuphBpYz4uGfVP6FAHqQ1OpItKHHthorcxDVrOYjPKTWncQDM-LZlmiPj1Phy3_1vkqEDK1wd7daPOcnSHoi5fKkptAxtRPrtBWgKE',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': ' FLUTTER_NOTIFICATION_CLICK ',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": "dbfood"
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
